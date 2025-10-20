Class {
	#name : 'PBTJSONPerfuzzWithTreeGrammarMutationTest',
	#superclass : 'PBTJSONTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTJSONPerfuzzWithTreeGrammarMutationTest >> jsonGenerator [

	| seed |
	seed := '{"n":true,"n":true,"x":6}'.

	^ PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: seed);
		  mutationsPerIteration: 10;
		  mutators: { (PBTTreeGrammarMutator from: JSONGrammar new mutationProbability: 50) };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'tests' }
PBTJSONPerfuzzWithTreeGrammarMutationTest >> setUp [ 

	super setUp.
	runner := PBTRunner test: NeoJSONReader class >> #fromString: from: schema for: 20 minutes.

]

{ #category : 'tests' }
PBTJSONPerfuzzWithTreeGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
