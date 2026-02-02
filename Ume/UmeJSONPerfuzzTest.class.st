Class {
	#name : 'UmeJSONPerfuzzTest',
	#superclass : 'UmeJSONTest',
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeJSONPerfuzzTest >> jsonGenerator [

	| mutator randomGenerator |
	randomGenerator := (PBTGrammarMCTSGenerator from: JSONGrammar new)
		                   maxSize: Float infinity.

	mutator := UmeMutator mutate: [ :input |
		           NeoJSONReader
			           mutate: input
			           with: (randomGenerator gen: nil) ].

	^ UmeCorpusGenerator new
		  seeds: { '{}' };
		  mutationsPerIteration: 10;
		  mutators: { mutator };
		  heuristic: UmePickBestElementDifferenceHeuristic new
]

{ #category : 'tests' }
UmeJSONPerfuzzTest >> testGuidingByMethodsCalls [ 

	| runner result |
	
	runner := (UmeRunner test: NeoJSONReader class >> #fromString: from: schema for: 5 minutes) guidedByMethodsCalls.
	result := runner run.
	
	self assert: (result tests size) equals: 10000.
]
