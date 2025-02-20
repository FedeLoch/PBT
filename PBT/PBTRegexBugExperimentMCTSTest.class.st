Class {
	#name : 'PBTRegexBugExperimentMCTSTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexBugExperimentMCTSTest >> regexConstraint [

	^ PBTObjectConstraint new generator: (PBTGrammarMCTSGenerator from: GncRegexGrammar new)
]

{ #category : 'tests' }
PBTRegexBugExperimentMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedScoreByTimeWithShallow [

	| pbtResult |
	
	schema guidedByScore.

	pbtResult := PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 10 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]
