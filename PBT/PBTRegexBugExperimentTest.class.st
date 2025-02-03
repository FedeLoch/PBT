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
		  generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100)
]

{ #category : 'running' }
PBTRegexBugExperimentTest >> setUp [

	| generator sharedProperties |
	
	super setUp.
	self timeLimit: 5 hours.

	sharedProperties := InternalConstraintProperties from:
		                    { ('grammar' -> self regexConstraint) }
			                    asDictionary.

	generator := PBTGenerator do: [ :props :feedback |
		             | regex |
		             regex := (props at: 'grammar') genBy: feedback.
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
			                        (PBTGenerator do: [ :props :feedback |
					                         props at: 'input' ])) }.

	assert := [ :regex :input :result | result ].
	
	score := [ :re :inputs :res | | coreScore gnoccoScore anotherRegex | "Replicating the score experiment"
		coreScore := res time asMilliSeconds.
		anotherRegex := inputs first asRegex.
		gnoccoScore := [ anotherRegex matches: inputs first ] timeToRunWithoutGC.
		coreScore / (gnoccoScore max: 1) "This allows us to avoid division by zero"
	].

	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          score: score;
		          assert: assert
]

{ #category : 'tests' }
PBTRegexBugExperimentTest >> testGivingARegexFuzzerGeneratorThenWeForceThePerformanceBug [

	| pbtResult |
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentTest >> testGivingARegexFuzzerGeneratorThenWeForceThePerformanceBugByTime [

	| pbtResult |
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes.

	self assert: (pbtResult tests size) equals: 10000.
]
