Class {
	#name : 'PBTRegexSDGenTest',
	#superclass : 'PBTRegexTest',
	#instVars : [
		'grammarRegex'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexSDGenTest >> regexConstraint [

	grammarRegex := GncRegexGrammar new.
	
	^ PBTObjectConstraint new generator: (PBTGrammarSdGenGenerator from: grammarRegex ofDepth: 10)
]

{ #category : 'tests' }
PBTRegexSDGenTest >> testGivingARegexFuzzerAndASDGenGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexSDGenTest >> testGivingARegexFuzzerAndASDGenGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTimeWithShallow [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByExecutionTime; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexSDGenTest >> testGivingARegexFuzzerAndSDGenSGeneratorThenWeForceThePerformanceBugGuidedByScoreByTimeWithShallow [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexSDGenTest >> testGuidingByMethodsCalls [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]
