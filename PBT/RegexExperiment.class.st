Class {
	#name : 'RegexExperiment',
	#superclass : 'GrammarBasePathologicalBugExperiment',
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

	| regex |
	regex := nil.

	[ regex ] whileNil: [
		[
		| maybe grammarConstraint |
		grammarConstraint := (props at: 'grammar').
		grammarConstraint feed: feedback.
		maybe := grammarConstraint gen.
		(PBTRegex fromString: maybe) compileRegex.
		regex := maybe ]
			on: Error
			do: [ :e | "1 halt." ] ].

	^ regex
]

{ #category : 'running' }
RegexExperiment >> schema: seed mutators: mutators mutationsPerIteration: n [

	| assert sharedProperties argumentConstraints receiverConstraint regexGenerator regexConstraint |
	
	regexConstraint := PBTObjectConstraint new generator: (PBTCorpusWithMutationsGenerator new
		seedGenerator: (PBTConstantGenerator new value: seed);
		mutationsPerIteration: n; mutators: mutators;
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

	^ { '' . 'a(a+b*)?(aa(aaa?c?ab?b?()a(bc?aaa|b)?))?a' }
]

{ #category : 'running' }
RegexExperiment >> targetMethod [

	^ RxMatcher >> #matches:
]
