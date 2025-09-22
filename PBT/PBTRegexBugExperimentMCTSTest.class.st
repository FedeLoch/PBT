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

	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'as yet unclassified' }
PBTRegexBugExperimentMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTimeWithShallow [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByExecutionTime; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'as yet unclassified' }
PBTRegexBugExperimentMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedByScoreByTimeWithShallow [

	| pbtResult |
	
	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedByguidedByAllocatedMemoryByTimeWithShallow [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes) guidedByAllocatedMemory; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]
