Class {
	#name : 'PBTRegexBugExperimentHillClimbingTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#instVars : [
		'regexGenerator'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingTest >> regexConstraint [


	| randomGenerator |
	randomGenerator := PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100).

	regexGenerator := PBTGenerator base: [ randomGenerator gen ] mutating: [ :regexString | RxMatcher mutate: regexString using: randomGenerator gen ].

	^ PBTObjectConstraint new generator: regexGenerator
]

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBug [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.
	
	self assert: (pbtResult tests size) equals: 10000.

]
