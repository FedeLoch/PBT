Class {
	#name : 'PBTDataFramePerfuzzWithGrammarMutationTest',
	#superclass : 'PBTDataFrameTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTDataFramePerfuzzWithGrammarMutationTest >> csvGenerator [

	| seed |
	seed := ''.

	^ PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: seed);
		  mutationsPerIteration: 10;
		  mutators: { (PBTGrammarMutator from: JSONGrammar new) };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTDataFramePerfuzzWithGrammarMutationTest >> setUp [ 

	super setUp.
	1 halt.
	runner := PBTRunner test: DataFrame class >> #readFromCsv: from: schema for: 5 minutes.

]

{ #category : 'tests' }
PBTDataFramePerfuzzWithGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
