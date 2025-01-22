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
		  generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new)
]

{ #category : 'running' }
PBTRegexBugExperimentTest >> setUp [

	| generator sharedProperties |
	
	super setUp.

	"
		1 - er = Get a string regex by grammar
		2 - s  = Get the minimum matcheable string
		3 - ER = Parse er to a real RxMatcher
		4 - test ER matches with s as argument
	"

	sharedProperties := InternalConstraintProperties from: { ('grammar' -> self regexConstraint) } asDictionary.

	generator := PBTGenerator do: [ :props | | regex |
		             regex := (props at: 'grammar') gen.
		1 halt.
		             props at: 'input' put: regex smallestStringMatching.
		             regex asRegex
	].

	receiverConstraint := PBTObjectConstraint new
		                      objectClass: RxMatcher;
		                      generator: generator;
		                      props: sharedProperties.

	argumentConstraints := {
		PBTObjectConstraint new
		  objectClass: String;
		  props: sharedProperties;
		  generator: (PBTGenerator do: [ :props | props at: 'input' ])
	}.
	
	assert := [ :rect :args :result |
	          1 halt.
	          result >= 0 ].
	score := [ :testCase |
	         1 halt.
	         testCase allocatedMemory ].

	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          score: score;
		          assert: assert
]

{ #category : 'tests' }
PBTRegexBugExperimentTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBug [

	| pbtResult |
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 10000.

]
