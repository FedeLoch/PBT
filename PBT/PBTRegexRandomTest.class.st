Class {
	#name : 'PBTRegexRandomTest',
	#superclass : 'PBTRegexTest',
	#instVars : [
		'regexGenerator'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexRandomTest >> regexConstraint [
		
	^ PBTObjectConstraint new generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100)
]

{ #category : 'tests' }
PBTRegexRandomTest >> testGivingARandomGeneratorThenWeForceThePerformanceBugGuidedScoreByTimeWithShallow [

	| pbtResult |
	
	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexRandomTest >> testGuidingByMethodsCalls [

	| pbtResult |
	
	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByMethodsCalls; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]
