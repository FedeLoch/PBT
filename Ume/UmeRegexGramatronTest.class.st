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
	
	^ UmeObjectConstraint new generator: (PBTGrammarGramatronGenerator from: grammarRegex ofDepth: 10)
]

{ #category : 'tests' }
UmeRegexGramatronTest >> testGivingARegexFuzzerAndAGramatronGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |

	pbtResult := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexGramatronTest >> testGivingARegexFuzzerAndAGramatronGeneratorThenWeForceThePerformanceBugGuidedByScoreByTimeWithShallow [

	| pbtResult |

	pbtResult := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexGramatronTest >> testGuidedByMethodsCalled [

	| pbtResult |

	pbtResult := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]
