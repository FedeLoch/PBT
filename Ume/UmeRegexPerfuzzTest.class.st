Class {
	#name : 'UmeRegexPerfuzzTest',
	#superclass : 'UmeRegexTest',
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeRegexPerfuzzTest >> regexConstraint [

	| mutator terminalString randomGenerator |
	terminalString := 'abc+|?*.'.

	randomGenerator := PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100.
	mutator := UmeMutator mutate: [ :regex | RxMatcher mutateCharacter: regex using: terminalString ].

	^ UmeObjectConstraint new generator: (UmeCorpusGenerator new
			   seedGenerator: randomGenerator;
			   mutators: { mutator };
			   heuristic: UmePickBestElementDifferenceHeuristic new
	)
]

{ #category : 'tests' }
UmeRegexPerfuzzTest >> testGuidingByMethodsCalls [ 

	| runner result |
	
	runner := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls.
	result := runner run.
	
	self assert: (result tests size) equals: 10000.
]
