Class {
	#name : 'UmeRegexMCTSTest',
	#superclass : 'UmeRegexTest',
	#instVars : [
		'grammarRegex'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeRegexMCTSTest >> regexConstraint [

	grammarRegex := GncRegexGrammar new.
	
	^ UmeObjectConstraint new generator: (UmeGrammarMCTSGenerator from: grammarRegex)
]

{ #category : 'as yet unclassified' }
UmeRegexMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |

	pbtResult := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'as yet unclassified' }
UmeRegexMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTimeWithShallow [

	| pbtResult |

	pbtResult := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByExecutionTime; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'as yet unclassified' }
UmeRegexMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedByScoreByTimeWithShallow [

	| pbtResult |
	
	pbtResult := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexMCTSTest >> testGivingARegexFuzzerAndAMCTSGeneratorThenWeForceThePerformanceBugGuidedByguidedByAllocatedMemoryByTimeWithShallow [

	| pbtResult |

	pbtResult := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 5 minutes) guidedByAllocatedMemory; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexMCTSTest >> testGuidedByMethodsCalled [

	| pbtResult |

	pbtResult := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes) guidedByMethodsCalls; run.
	
	self assert: (pbtResult tests size) equals: 10000.
]
