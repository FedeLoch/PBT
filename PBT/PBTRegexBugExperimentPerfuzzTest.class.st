Class {
	#name : 'PBTRegexBugExperimentPerfuzzTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexBugExperimentPerfuzzTest >> regexConstraint [

	| mutator terminalString |
	terminalString := 'abc+|?*.'.

	mutator := PBTMutator mutate: [ :regexString | RxMatcher mutateCharacter: regexString using: terminalString ].

	^ PBTObjectConstraint new generator: (PBTCorpusWithMutationsGenerator new
			   generator: (PBTGrammarMCTSGenerator from: GncRegexGrammar new);
			   mutators: { mutator };
			   heuristic: PBTPickLastSelectorHeuristic new
	)
]

{ #category : 'tests' }
PBTRegexBugExperimentPerfuzzTest >> testGuidingByMethodsCalls [ 

	| runner result |
	
	runner := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls.
	result := runner run.
	
	self assert: (result tests size) equals: 10000.

]
