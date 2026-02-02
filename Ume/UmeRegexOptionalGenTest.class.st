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

	regexGenerator := UmeDyncamicSelectionGenerator new generators: {
		UmeGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 1; maxSize: 100.
		UmeGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 5.
		UmeGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 20; maxSize: 20.
		UmeGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 10; maxSize: 40.
		UmeGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 40; maxSize: 10.
		UmeGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 40; maxSize: 40.
		UmeGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 80; maxSize: 80.
		UmeGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100
	}.
	
	^ UmeObjectConstraint new generator: regexGenerator
]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemory [

	| pbtResult |
	
	pbtResult := (UmeRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByAllocatedMemory; run.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemoryByTime [

	| pbtResult |
	
	pbtResult := (UmeRunner test: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByAllocatedMemory; run.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByCoverage [

	| pbtResult |
	
	pbtResult := (UmeRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByCoverage; run.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |
	
	pbtResult := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByExecutionTime [

	| pbtResult |
	
	pbtResult := (UmeRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByExecutionTime; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTime [

	| pbtResult |
	
	pbtResult := (UmeRunner test: RxMatcher >> #matches: from: schema for: 1 second) guidedByExecutionTime; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexOptionalGenTest >> testGuidingByMethodsCalls [ 

	| pbtResult |
	
	pbtResult := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls ; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]
