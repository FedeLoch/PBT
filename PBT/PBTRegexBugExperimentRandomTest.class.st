Class {
	#name : 'PBTRegexBugExperimentRandomTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#instVars : [
		'regexGenerator'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexBugExperimentRandomTest >> regexConstraint [
		
	^ PBTObjectConstraint new generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100)
]

{ #category : 'tests' }
PBTRegexBugExperimentRandomTest >> testGivingARandomGeneratorThenWeForceThePerformanceBugGuidedScoreByTimeWithShallow [

	| pbtResult |
	
	schema guidedByScore.

	pbtResult := PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes.
	
	self assert: (pbtResult tests size) equals: 10000.

]
