Class {
	#name : 'UmeJSONPerfuzzWithGrammarMutationTest',
	#superclass : 'UmeJSONTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeJSONPerfuzzWithGrammarMutationTest >> jsonGenerator [

	| seeds |
	seeds := { '{"n":true,"n":true,"x":6}' }.

	^ PBTCorpusGenerator new
		  seeds: seeds;
		  mutationsPerIteration: 100;
		  mutators: { (PBTGrammarLiteralsMutator from: JSONGrammar new) };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'tests' }
UmeJSONPerfuzzWithGrammarMutationTest >> setUp [ 

	super setUp.
	runner := PBTRunner test: NeoJSONReader class >> #fromString: from: schema for: 5 minutes.

]

{ #category : 'tests' }
UmeJSONPerfuzzWithGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
