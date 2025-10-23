Class {
	#name : 'PBTRegexTest',
	#superclass : 'PBTFrameworkTest',
	#instVars : [
		'schema',
		'receiverConstraint',
		'argumentConstraints',
		'assert',
		'score'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTRegexTest >> regexByProp: props and: feedback [

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
PBTRegexTest >> regexConstraint [

	^ PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100)
]

{ #category : 'running' }
PBTRegexTest >> setUp [

	| generator sharedProperties |
	
	super setUp.
	self timeLimit: 5 hours.

	sharedProperties := InternalConstraintProperties from:
		                    { ('grammar' -> self regexConstraint) }
			                    asDictionary.

	generator := PBTGenerator do: [ :props :feedback |
		             | regex |
		             regex := self regexByProp: props and: feedback.
		             props at: 'input' put: regex minimalStringMatching.
						 PBTRegex fromString: regex ].

	receiverConstraint := PBTObjectConstraint new
		                      objectClass: RxMatcher;
		                      generator: generator;
		                      props: sharedProperties.

	argumentConstraints := { (PBTObjectConstraint new
		                        objectClass: String;
		                        props: sharedProperties;
		                        generator:
			                        (PBTGenerator do: [ :props :feedback |
					                         props at: 'input' ])) }.

	assert := [ :regex :input :result | result ].
	
	score := [ :re :inputs :res | | coreScore gnoccoScore anotherRegex base |
		res profilingResult ifNil: [ -1 ] ifNotNil: [
			coreScore := res profilingResult executionTime.
			anotherRegex := inputs first asRegex.
		
			base := Time microsecondClockValue.
			anotherRegex matches: inputs first.
			gnoccoScore := Time microsecondClockValue - base.
			(coreScore / (gnoccoScore max: 1)) asFloat "This allows us to avoid division by zero"
		] 
	].

	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          score: score;
		          assert: assert
]

{ #category : 'tests' }
PBTRegexTest >> testGivingARegexFuzzerGeneratorThenWeForceThePerformanceBug [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema times: 10000) run.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexTest >> testGivingARegexFuzzerGeneratorThenWeForceThePerformanceBugByTime [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) run.

	self assert: (pbtResult tests size) equals: 10000.
]
