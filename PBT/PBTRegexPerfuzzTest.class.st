Class {
	#name : 'PBTRegexPerfuzzTest',
	#superclass : 'PBTRegexTest',
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTRegexPerfuzzTest >> regexConstraint [

	| mutator terminalString randomGenerator |
	terminalString := 'abc+|?*.'.

	randomGenerator := PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100.
	mutator := PBTMutator mutate: [ :regex | RxMatcher mutateCharacter: regex using: terminalString ].

	^ PBTObjectConstraint new generator: (PBTCorpusGenerator new
			   seedGenerator: randomGenerator;
			   mutators: { mutator };
			   heuristic: PBTPickBestElementDifferenceHeuristic new
	)
]

{ #category : 'tests' }
PBTRegexPerfuzzTest >> testGuidingByMethodsCalls [ 

	| runner result |
	
	runner := (PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls.
	result := runner run.
	
	self assert: (result tests size) equals: 10000.
]
