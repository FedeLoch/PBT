Class {
	#name : 'UmeRegexGramatronTest',
	#superclass : 'UmeRegexTest',
	#instVars : [
		'grammarRegex'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeRegexGramatronTest >> regexConstraint [

	grammarRegex := GnfRegexGrammar new.
	
	^ UmeObjectConstraint new generator: (UmeGrammarGramatronGenerator from: grammarRegex ofDepth: 10)
]

{ #category : 'tests' }
UmeRegexGramatronTest >> testGivingARegexFuzzerAndAGramatronGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| result |

	result := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexGramatronTest >> testGivingARegexFuzzerAndAGramatronGeneratorThenWeForceThePerformanceBugGuidedByScoreByTimeWithShallow [

	| result |

	result := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes) guidedByScore; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexGramatronTest >> testGuidedByMethodsCalled [

	| result |

	result := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls; run.
	
	self assert: (result tests size) equals: 10000.

]
