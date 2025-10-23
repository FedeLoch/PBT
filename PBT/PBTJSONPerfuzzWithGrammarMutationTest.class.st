Class {
	#name : 'PBTJSONPerfuzzWithGrammarMutationTest',
	#superclass : 'PBTJSONTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTJSONPerfuzzWithGrammarMutationTest >> jsonGenerator [

	| seed |
	seed := '{"n":true,"n":true,"x":6}'.

	^ PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: seed);
		  mutationsPerIteration: 100;
		  mutators: { (PBTGrammarMutator from: JSONGrammar new) };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'tests' }
PBTJSONPerfuzzWithGrammarMutationTest >> setUp [ 

	super setUp.
	runner := PBTRunner test: NeoJSONReader class >> #fromString: from: schema for: 5 minutes.

]

{ #category : 'tests' }
PBTJSONPerfuzzWithGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
