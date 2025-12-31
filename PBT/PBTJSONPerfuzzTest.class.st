Class {
	#name : 'PBTJSONPerfuzzTest',
	#superclass : 'PBTJSONTest',
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTJSONPerfuzzTest >> jsonGenerator [

	| mutator randomGenerator |
	randomGenerator := (PBTGrammarMCTSGenerator from: JSONGrammar new)
		                   maxSize: Float infinity.

	mutator := PBTMutator mutate: [ :input |
		           NeoJSONReader
			           mutate: input
			           with: (randomGenerator gen: nil) ].

	^ PBTCorpusWithMutationsGenerator new
		  seeds: { '{}' };
		  mutationsPerIteration: 10;
		  mutators: { mutator };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'tests' }
PBTJSONPerfuzzTest >> testGuidingByMethodsCalls [ 

	| runner result |
	
	runner := (PBTRunner test: NeoJSONReader class >> #fromString: from: schema for: 5 minutes) guidedByMethodsCalls.
	result := runner run.
	
	self assert: (result tests size) equals: 10000.
]
