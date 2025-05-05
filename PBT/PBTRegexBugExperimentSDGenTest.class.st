Class {
	#name : 'PBTRegexBugExperimentSDGenTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#instVars : [
		'grammarRegex'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexBugExperimentSDGenTest >> regexConstraint [

	grammarRegex := GncRegexGrammar new.
	
	^ PBTObjectConstraint new generator: (PBTGrammarSdGenGenerator from: grammarRegex ofDepth: 10)
]

{ #category : 'tests' }
PBTRegexBugExperimentSDGenTest >> testGivingARegexFuzzerAndASDGenGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |
	
	schema guidedByCoverage.

	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentSDGenTest >> testGivingARegexFuzzerAndASDGenGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTimeWithShallow [

	| pbtResult |
	
	schema guidedByExecutionTime.

	pbtResult := PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentSDGenTest >> testGivingARegexFuzzerAndSDGenSGeneratorThenWeForceThePerformanceBugGuidedByScoreByTimeWithShallow [

	| pbtResult |
	
	schema guidedByScore.

	pbtResult := PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]
