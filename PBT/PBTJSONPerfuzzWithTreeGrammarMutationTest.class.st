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

	| seeds |
	seeds := { '[]' . '{"n":true,"n":[],"x":6}' }.

	^ PBTCorpusGenerator new
		  seeds: seeds;
		  mutationsPerIteration: 3;
		  mutators: {
				(PBTGrammarDerivationMutator from: JSONGrammar new) maxInputSize: 100.
				(PBTGrammarLiteralsMutator from: JSONGrammar new) maxInputSize: 100.
		  };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'tests' }
PBTJSONPerfuzzWithTreeGrammarMutationTest >> setUp [ 

	super setUp.
	runner := PBTRunner test: NeoJSONReader class >> #fromString: from: schema for: 5 minutes.

]

{ #category : 'tests' }
PBTJSONPerfuzzWithTreeGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
