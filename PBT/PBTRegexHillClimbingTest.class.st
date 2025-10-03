Class {
	#name : 'PBTRegexHillClimbingTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#instVars : [
		'regexGenerator'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'tests' }
PBTRegexHillClimbingTest >> regexConstraint [


	| randomGenerator |
	randomGenerator := PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100).

	regexGenerator := PBTGenerator base: [ | re |
		re := randomGenerator gen.
		[ re size = 40 ] whileFalse: [ re := randomGenerator gen ].
		re ] mutating: [ :regexString :constraint :feedback | RxMatcher mutateCharacter: regexString using: randomGenerator gen ].

	^ PBTObjectConstraint new generator: regexGenerator
]

{ #category : 'tests' }
PBTRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemory [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema times: 1000) guidedByAllocatedMemory; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemoryByTime [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByAllocatedMemory; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByCoverage [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByCoverage; run.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByExecutionTime [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByExecutionTime; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTime [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByExecutionTime; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedScore [

	| pbtResult |

	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedScoreByTime [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedScoreByTimeWithShallow [

	| pbtResult |
	
	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexHillClimbingTest >> testGuidedByMethodsCalled [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]
