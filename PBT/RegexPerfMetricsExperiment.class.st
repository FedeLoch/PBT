Class {
	#name : 'RegexPerfMetricsExperiment',
	#superclass : 'PerformanceMetricsPaperExperiment',
	#category : 'PBT-Paper Experimentation',
	#package : 'PBT',
	#tag : 'Paper Experimentation'
}

{ #category : 'running' }
RegexPerfMetricsExperiment >> libraryName [

	^ 'Regex'
]

{ #category : 'running' }
RegexPerfMetricsExperiment >> maxSize [

	^ 41
]

{ #category : 'running' }
RegexPerfMetricsExperiment >> newGrammar [

	^ GncRegexGrammar new
]

{ #category : 'running' }
RegexPerfMetricsExperiment >> regexByProp: props and: feedback [

	| regex grammarConstraint |
	regex := nil.
	
	grammarConstraint := (props at: 'grammar').
	grammarConstraint feed: feedback.

	[ regex ] whileNil: [ [ | maybe |
		maybe := grammarConstraint gen.
		(PBTRegex fromString: maybe) compileRegex.
		regex := maybe ]
			on: Error
			do: [ :e | "1 halt." ] ].

	^ regex
]

{ #category : 'running' }
RegexPerfMetricsExperiment >> schema [

	| assert sharedProperties argumentConstraints receiverConstraint regexGenerator regexConstraint |
	
	regexConstraint := PBTObjectConstraint new
		unwrap: [ :case | (case class = PBTRegex) ifTrue: [ case regexString ] ifFalse: [ case ] ];
		generator: (PBTCorpusWithMutationsGenerator new
		seedGenerator: (PBTConstantGenerator new value: self seed);
		mutationsPerIteration: self mpi; mutators: self mutators;
		heuristic: PBTPickBestElementDifferenceHeuristic new).
	
	sharedProperties := InternalConstraintProperties
		from: { ('grammar' -> regexConstraint) } asDictionary.
	
	regexGenerator := PBTGenerator do: [ :props :feedback | | regex |
		regex := self regexByProp: props and: feedback.
		props at: 'input' put: regex minimalStringMatching.
		PBTRegex fromString: regex ].
	
	receiverConstraint := PBTObjectConstraint new objectClass: RxMatcher;
		generator: regexGenerator;
		props: sharedProperties.
	
	argumentConstraints := {
		(PBTObjectConstraint new objectClass: String;
			props: sharedProperties;
			generator: (PBTGenerator do: [ :props :feedback | props at: 'input' ]))
	}.
	
	assert := [ :regex :input :result | result ].
	
	^ PBTSchema new
		receiverConstraint: receiverConstraint;
		argumentConstraints: argumentConstraints;
		assert: assert
]

{ #category : 'accessing' }
RegexPerfMetricsExperiment >> seed [

	^ 'ac?ab?ab?b?aa.?aaab?c?a(c)?ac?aaab?a?a'
]

{ #category : 'running' }
RegexPerfMetricsExperiment >> targetMethod [

	^ RxMatcher >> #matches:
]
