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
	
	schema guidedByCoverage.

	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentGramatronTest >> testGivingARegexFuzzerAndAGramatronGeneratorThenWeForceThePerformanceBugGuidedByScoreByTimeWithShallow [

	| pbtResult |
	
	schema guidedByScore.

	pbtResult := PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]
