Class {
	#name : 'PBTRegexBugExperimentMCTSTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#instVars : [
		'grammarRegex'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexBugExperimentMCTSTest >> regexConstraint [

	grammarRegex := GncRegexGrammar new.
	
	^ PBTObjectConstraint new generator: (PBTGrammarMCTSGenerator from: grammarRegex)
]

{ #category : 'as yet unclassified' }
PBTRegexBugExperimentMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |
	
	schema guidedByCoverage.

	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'as yet unclassified' }
PBTRegexBugExperimentMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTimeWithShallow [

	| pbtResult |
	
	schema guidedByExecutionTime.

	pbtResult := PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'as yet unclassified' }
PBTRegexBugExperimentMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedByScoreByTimeWithShallow [

	| pbtResult |
	
	schema guidedByScore.

	pbtResult := PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedByguidedByAllocatedMemoryByTimeWithShallow [

	| pbtResult |
	
	schema guidedByAllocatedMemory.

	pbtResult := PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]
