Class {
	#name : 'PBTRegexBugExperimentTest',
	#superclass : 'PBTFrameworkTest',
	#instVars : [
		'schema',
		'receiverConstraint',
		'argumentConstraints',
		'assert',
		'score'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexBugExperimentTest >> regexConstraint [

	^ PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 20)
]

{ #category : 'running' }
PBTRegexBugExperimentTest >> setUp [

	| generator sharedProperties |
	super setUp.

	sharedProperties := InternalConstraintProperties from:
		                    { ('grammar' -> self regexConstraint) }
			                    asDictionary.

	generator := PBTGenerator do: [ :props |
		             | regex |
		             regex := (props at: 'grammar') gen.
		             props at: 'input' put: regex minimalStringMatching.
		             regex asRegex ].

	receiverConstraint := PBTObjectConstraint new
		                      objectClass: RxMatcher;
		                      generator: generator;
		                      props: sharedProperties.

	argumentConstraints := { (PBTObjectConstraint new
		                        objectClass: String;
		                        props: sharedProperties;
		                        generator:
			                        (PBTGenerator do: [ :props |
					                         props at: 'input' ])) }.

	assert := [ :regex :input :result | result ].
	score := [ :re :arg :res | re asString size ].

	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          score: score;
		          assert: assert
]

{ #category : 'tests' }
PBTRegexBugExperimentTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBug [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.
	
	self assert: (pbtResult tests size) equals: 10000.

]
