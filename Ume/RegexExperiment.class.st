Class {
	#name : 'RegexExperiment',
	#superclass : 'GrammarBasePathologicalBugMutatorPaperExperiment',
	#category : 'Ume-Paper Experimentation',
	#package : 'Ume',
	#tag : 'Paper Experimentation'
}

{ #category : 'running' }
RegexExperiment >> maxInputSize [

	^ 41
]

{ #category : 'running' }
RegexExperiment >> name [

	^ 'PharoRegex'
]

{ #category : 'running' }
RegexExperiment >> newGrammar [

	^ GncRegexGrammar new
]

{ #category : 'running' }
RegexExperiment >> regexByProp: props and: feedback [

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
RegexExperiment >> schemaCorpusWith: mutators [

| assert sharedProperties argumentConstraints receiverConstraint regexGenerator regexConstraint |

	regexConstraint := UmeObjectConstraint new
		unwrap: [ :case | (case class = PBTRegex) ifTrue: [ case regexString ] ifFalse: [ case ] ];
		generator: (UmeCorpusGenerator new
		seeds: self seeds deepCopy;
		mutationsPerIteration: self mpi; mutators: mutators;
		heuristic: UmePickBestElementDifferenceHeuristic new).
	
	sharedProperties := UmeInternalConstraintProperties
		from: { ('grammar' -> regexConstraint) } asDictionary.
	
	regexGenerator := UmeGenerator do: [ :props :feedback | | regex |
		regex := self regexByProp: props and: feedback.
		props at: 'input' put: regex minimalStringMatching.
		PBTRegex fromString: regex ].
	
	receiverConstraint := UmeObjectConstraint new objectClass: RxMatcher;
		generator: regexGenerator;
		props: sharedProperties.
	
	argumentConstraints := {
		(UmeObjectConstraint new objectClass: String;
			props: sharedProperties;
			generator: (UmeGenerator do: [ :props :feedback | props at: 'input' ]))
	}.
	
	assert := [ :regex :input :result | result ].
	
	^ UmeSchema new
		receiverConstraint: receiverConstraint;
		argumentConstraints: argumentConstraints;
		assert: assert
]

{ #category : 'running' }
RegexExperiment >> seeds [

	^ { 'a' . 'ac?ab?ab?b?aa.?aaab?c?a(c)?ac?aaab?a?a' }
]

{ #category : 'running' }
RegexExperiment >> targetMethod [

	^ RxMatcher >> #matches:
]

{ #category : 'running' }
RegexExperiment >> weightedGrammarSchema [

| assert sharedProperties argumentConstraints receiverConstraint regexGenerator regexConstraint |

	regexConstraint := UmeObjectConstraint new
		unwrap: [ :case | (case class = PBTRegex) ifTrue: [ case regexString ] ifFalse: [ case ] ];
		generator: (UmeGrammarGenerator new grammar: self newGrammar; maxSize: self maxInputSize).
	
	sharedProperties := UmeInternalConstraintProperties
		from: { ('grammar' -> regexConstraint) } asDictionary.
	
	regexGenerator := UmeGenerator do: [ :props :feedback | | regex |
		regex := self regexByProp: props and: feedback.
		props at: 'input' put: regex minimalStringMatching.
		PBTRegex fromString: regex ].
	
	receiverConstraint := UmeObjectConstraint new objectClass: RxMatcher;
		generator: regexGenerator;
		props: sharedProperties.
	
	argumentConstraints := {
		(UmeObjectConstraint new objectClass: String;
			props: sharedProperties;
			generator: (UmeGenerator do: [ :props :feedback | props at: 'input' ]))
	}.
	
	assert := [ :regex :input :result | result ].
	
	^ UmeSchema new
		receiverConstraint: receiverConstraint;
		argumentConstraints: argumentConstraints;
		assert: assert
]
