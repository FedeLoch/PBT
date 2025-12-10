Class {
	#name : 'PBTJSONPerfuzzWithTreeGrammarMutationTest',
	#superclass : 'PBTJSONTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTJSONPerfuzzWithTreeGrammarMutationTest >> jsonGenerator [

	| seed |
	seed := '{"n":true,"n":[],"x":6}'.

	^ PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: seed);
		  mutationsPerIteration: 3;
		  mutators: { (PBTTreeGrammarMutator from: JSONGrammar new) maxInputSize: 100 };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'tests' }
PBTJSONPerfuzzWithTreeGrammarMutationTest >> setUp [ 

	super setUp.
	runner := PBTRunner test: NeoJSONReader class >> #fromString: from: schema for: 10 minutes.

]

{ #category : 'tests' }
PBTJSONPerfuzzWithTreeGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
