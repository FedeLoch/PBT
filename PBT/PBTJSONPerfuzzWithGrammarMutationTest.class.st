Class {
	#name : 'PBTJSONPerfuzzWithGrammarMutationTest',
	#superclass : 'PBTJSONTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTJSONPerfuzzWithGrammarMutationTest >> jsonGenerator [

		| seed |
		
		seed := '{"n":true,"n":true,"x":6}'.
		
		^ PBTCorpusWithMutationsGenerator new
			   seedGenerator: (PBTConstantGenerator new value: seed);
			   mutationsPerIteration: 10;
			   mutators: {
					PBTGrammarMutator from: JSONGrammar new
				};
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
