Class {
	#name : 'RegexExperiment',
	#superclass : 'GrammarBasePathologicalBugMutatorPaperExperiment',
	#category : 'PBT-Paper Experimentation',
	#package : 'PBT',
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

	regexConstraint := PBTObjectConstraint new
		unwrap: [ :case | (case class = PBTRegex) ifTrue: [ case regexString ] ifFalse: [ case ] ];
		generator: (PBTCorpusWithMutationsGenerator new
		seeds: self seeds deepCopy;
		mutationsPerIteration: self mpi; mutators: mutators;
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

	regexConstraint := PBTObjectConstraint new
		unwrap: [ :case | (case class = PBTRegex) ifTrue: [ case regexString ] ifFalse: [ case ] ];
		generator: (PBTGrammarGenerator new grammar: self newGrammar; maxSize: self maxInputSize).
	
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
