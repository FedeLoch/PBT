Class {
	#name : 'PBTRegexBugExperimentGramatronTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#instVars : [
		'grammarRegex'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexBugExperimentGramatronTest >> regexConstraint [

	grammarRegex := GnfRegexGrammar new.
	
	^ PBTObjectConstraint new generator: (PBTGrammarGramatronGenerator from: grammarRegex ofDepth: 10)
]

{ #category : 'tests' }
PBTRegexBugExperimentGramatronTest >> testGivingARegexFuzzerAndAGramatronGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |

	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentGramatronTest >> testGivingARegexFuzzerAndAGramatronGeneratorThenWeForceThePerformanceBugGuidedByScoreByTimeWithShallow [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]
