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
PBTRegexBugExperimentOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBug [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.
	
	self assert: (pbtResult tests size) equals: 1000.

]
