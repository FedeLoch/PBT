Class {
	#name : 'PBTRegexGenericPerfuzzTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexGenericPerfuzzTest >> regexConstraint [

	| mutator terminalString randomGenerator |
	terminalString := 'abc+|?*.'.

	randomGenerator := PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100.
	mutator := PBTMutator mutate: [ :regex | RxMatcher mutateCharacter: regex using: terminalString ].

	^ PBTObjectConstraint new generator: (PBTCorpusWithMutationsGenerator new
			   seedGenerator: randomGenerator;
			   mutators: { mutator };
			   heuristic: PBTPickBestElementDifferenceHeuristic new
	)
]

{ #category : 'tests' }
PBTRegexGenericPerfuzzTest >> testGuidingByMethodsCalls [ 

	| runner result |
	
	runner := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls.
	result := runner run.
	
	self assert: (result tests size) equals: 10000.
]
