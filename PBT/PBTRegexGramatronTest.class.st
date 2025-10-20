Class {
	#name : 'PBTRegexGramatronTest',
	#superclass : 'PBTRegexTest',
	#instVars : [
		'grammarRegex'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTRegexGramatronTest >> regexConstraint [

	grammarRegex := GnfRegexGrammar new.
	
	^ PBTObjectConstraint new generator: (PBTGrammarGramatronGenerator from: grammarRegex ofDepth: 10)
]

{ #category : 'tests' }
PBTRegexGramatronTest >> testGivingARegexFuzzerAndAGramatronGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |

	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexGramatronTest >> testGivingARegexFuzzerAndAGramatronGeneratorThenWeForceThePerformanceBugGuidedByScoreByTimeWithShallow [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexGramatronTest >> testGuidedByMethodsCalled [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]
