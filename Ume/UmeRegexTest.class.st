Class {
	#name : 'UmeRegexTest',
	#superclass : 'UmeFrameworkTest',
	#instVars : [
		'schema',
		'receiverConstraint',
		'argumentConstraints',
		'assert',
		'score'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeRegexTest >> regexByProp: props and: feedback [

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
UmeRegexTest >> regexConstraint [

	^ UmeObjectConstraint new
		  objectClass: String;
		  generator: (UmeGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100)
]

{ #category : 'accessing' }
UmeRegexTest >> seed [

	^ 'ac?ab?ab?b?aa.?aaab?c?a(c)?ac?aaab?a?a'
]

{ #category : 'running' }
UmeRegexTest >> setUp [

	| generator sharedProperties |
	
	super setUp.
	self timeLimit: 5 hours.

	sharedProperties := UmeInternalConstraintProperties from:
		                    { ('grammar' -> self regexConstraint) }
			                    asDictionary.

	generator := UmeGenerator do: [ :props :feedback |
		             | regex |
		             regex := self regexByProp: props and: feedback.
		             props at: 'input' put: regex minimalStringMatching.
						 PBTRegex fromString: regex ].

	receiverConstraint := UmeObjectConstraint new
		                      objectClass: RxMatcher;
		                      generator: generator;
		                      props: sharedProperties.

	argumentConstraints := { (UmeObjectConstraint new
		                        objectClass: String;
		                        props: sharedProperties;
		                        generator:
			                        (UmeGenerator do: [ :props :feedback |
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

	schema := UmeSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          score: score;
		          assert: assert
]

{ #category : 'tests' }
UmeRegexTest >> testGivingARegexFuzzerGeneratorThenWeForceThePerformanceBug [

	| pbtResult |
	
	pbtResult := (UmeRunner test: RxMatcher >> #matches: from: schema times: 10000) run.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexTest >> testGivingARegexFuzzerGeneratorThenWeForceThePerformanceBugByTime [

	| pbtResult |
	
	pbtResult := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) run.

	self assert: (pbtResult tests size) equals: 10000.
]
