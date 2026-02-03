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

	^ UmeCorpusGenerator new
		  seeds: seeds;
		  mutationsPerIteration: 100;
		  mutators: { (UmeGrammarLiteralsMutator from: JSONGrammar new) };
		  heuristic: UmePickBestElementDifferenceHeuristic new
]

{ #category : 'tests' }
UmeJSONPerfuzzWithGrammarMutationTest >> setUp [ 

	super setUp.
	runner := UmeRunner test: NeoJSONReader class >> #fromString: from: schema for: 5 minutes.

]

{ #category : 'tests' }
UmeJSONPerfuzzWithGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
