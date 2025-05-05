Class {
	#name : 'PBTRegexBugExperimentOptionalGenTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#instVars : [
		'regexGenerator'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'tests' }
PBTRegexBugExperimentOptionalGenTest >> regexConstraint [

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
PBTRegexBugExperimentOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemory [

	| pbtResult |
	
	schema guidedByAllocatedMemory.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemoryByTime [

	| pbtResult |
	
	schema guidedByAllocatedMemory.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByCoverage [

	| pbtResult |
	
	schema guidedByCoverage.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| pbtResult |
	
	schema guidedByCoverage.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByExecutionTime [

	| pbtResult |
	
	schema guidedByExecutionTime.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTime [

	| pbtResult |
	
	schema guidedByExecutionTime.
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 1 second.
	
	self assert: (pbtResult tests size) equals: 10000.

]
