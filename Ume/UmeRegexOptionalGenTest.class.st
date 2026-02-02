Class {
	#name : 'UmeRegexOptionalGenTest',
	#superclass : 'UmeRegexTest',
	#instVars : [
		'regexGenerator'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'tests' }
UmeRegexOptionalGenTest >> regexConstraint [

	regexGenerator := PBTDyncamicSelectionGenerator new generators: {
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 1; maxSize: 100.
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 5.
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 20; maxSize: 20.
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 10; maxSize: 40.
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 40; maxSize: 10.
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 40; maxSize: 40.
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 80; maxSize: 80.
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100
	}.
	
	^ PBTObjectConstraint new generator: regexGenerator
]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemory [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByAllocatedMemory; run.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemoryByTime [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByAllocatedMemory; run.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByCoverage [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByCoverage; run.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByExecutionTime [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByExecutionTime; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTime [

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 1 second) guidedByExecutionTime; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGuidingByMethodsCalls [ 

	| pbtResult |
	
	pbtResult := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls ; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]
