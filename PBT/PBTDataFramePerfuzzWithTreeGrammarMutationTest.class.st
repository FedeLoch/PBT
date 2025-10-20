Class {
	#name : 'PBTDataFramePerfuzzWithTreeGrammarMutationTest',
	#superclass : 'PBTDataFrameTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTDataFramePerfuzzWithTreeGrammarMutationTest >> csvGenerator [

	^ PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: self seed);
		  mutationsPerIteration: 10;
		  mutators: { (PBTTreeGrammarMutator from: CSVGrammar new mutationProbability: 10) };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTDataFramePerfuzzWithTreeGrammarMutationTest >> setUp [ 

	super setUp.
	1 halt.
	runner := PBTRunner test: DataFrame class >> #readFromCsv: from: schema for: 5 minutes.

]

{ #category : 'tests' }
PBTDataFramePerfuzzWithTreeGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
