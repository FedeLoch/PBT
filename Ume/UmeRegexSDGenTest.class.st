Class {
	#name : 'UmeRegexSDGenTest',
	#superclass : 'UmeRegexTest',
	#instVars : [
		'grammarRegex'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeRegexSDGenTest >> regexConstraint [

	grammarRegex := GncRegexGrammar new.
	
	^ UmeObjectConstraint new generator: (UmeGrammarSdGenGenerator from: grammarRegex ofDepth: 10)
]

{ #category : 'tests' }
UmeRegexSDGenTest >> testGivingARegexFuzzerAndASDGenGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| result |
	
	result := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexSDGenTest >> testGivingARegexFuzzerAndASDGenGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTimeWithShallow [

	| result |

	result := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByExecutionTime; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexSDGenTest >> testGivingARegexFuzzerAndSDGenSGeneratorThenWeForceThePerformanceBugGuidedByScoreByTimeWithShallow [

	| result |

	result := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByScore; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexSDGenTest >> testGuidingByMethodsCalls [

	| result |

	result := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls; run.
	
	self assert: (result tests size) equals: 10000.

]
