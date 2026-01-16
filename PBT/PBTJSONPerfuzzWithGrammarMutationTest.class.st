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

	| seeds |
	seeds := { '{"n":true,"n":true,"x":6}' }.

	^ PBTCorpusGenerator new
		  seeds: seeds;
		  mutationsPerIteration: 100;
		  mutators: { (PBTGrammarLiteralsMutator from: JSONGrammar new) };
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
