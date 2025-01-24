Class {
	#name : 'PBTRegexBugExperimentOptionalGenTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'tests' }
PBTRegexBugExperimentOptionalGenTest >> regexConstraint [

	| subGenerators |

	subGenerators := {
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 5.
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 20; maxSize: 20.
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 10; maxSize: 40.
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 40; maxSize: 10.
		PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 40; maxSize: 40
	}.
	
	^ PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTDyncamicSelectionGenerator new generators: subGenerators)
]

{ #category : 'tests' }
PBTRegexBugExperimentOptionalGenTest >> testGivingARegexFuzzerAndAnOptionalGeneratorThenWeForceThePerformanceBug [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 100000.
	
	self assert: (pbtResult tests size) equals: 10000.

]
