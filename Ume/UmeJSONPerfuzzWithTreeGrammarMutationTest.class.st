Class {
	#name : 'UmeJSONPerfuzzWithTreeGrammarMutationTest',
	#superclass : 'UmeJSONTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeJSONPerfuzzWithTreeGrammarMutationTest >> jsonGenerator [

	| seeds |
	seeds := { '[]' . '{"n":true,"n":[],"x":6}' }.

	^ UmeCorpusGenerator new
		  seeds: seeds;
		  mutationsPerIteration: 3;
		  mutators: {
				(UmeGrammarDerivationMutator from: JSONGrammar new) maxInputSize: 100.
		  };
		  heuristic: UmePickBestElementDifferenceHeuristic new
]

{ #category : 'tests' }
UmeJSONPerfuzzWithTreeGrammarMutationTest >> setUp [ 

	super setUp.
	runner := UmeRunner test: NeoJSONReader class >> #fromString: from: schema for: 5 minutes.

]

{ #category : 'tests' }
UmeJSONPerfuzzWithTreeGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
