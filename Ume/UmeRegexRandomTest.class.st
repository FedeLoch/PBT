Class {
	#name : 'UmeRegexRandomTest',
	#superclass : 'UmeRegexTest',
	#instVars : [
		'regexGenerator'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeRegexRandomTest >> regexConstraint [
		
	^ UmeObjectConstraint new generator: (UmeGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100)
]

{ #category : 'tests' }
UmeRegexRandomTest >> testGivingARandomGeneratorThenWeForceThePerformanceBugGuidedScoreByTimeWithShallow [

	| result |
	
	result := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes) guidedByScore; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexRandomTest >> testGuidingByMethodsCalls [

	| result |
	
	result := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByMethodsCalls; run.
	
	self assert: (result tests size) equals: 10000.

]
