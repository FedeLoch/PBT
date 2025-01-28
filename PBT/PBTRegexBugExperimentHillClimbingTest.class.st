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
PBTRegexBugExperimentHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemory [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	
	schema guidedByAllocatedMemory.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemoryByTime [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	
	schema guidedByAllocatedMemory.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByCoverage [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	
	schema guidedByCoverage.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	
	schema guidedByCoverage.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 5 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByExecutionTime [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	
	schema guidedByExecutionTime.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTime [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	
	schema guidedByExecutionTime.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 5 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedScore [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	
	schema guidedByScore.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedScoreByTime [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	
	schema guidedByScore.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 5 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]
