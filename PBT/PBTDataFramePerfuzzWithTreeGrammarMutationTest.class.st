Class {
	#name : 'PBTDataFramePerfuzzWithTreeGrammarMutationTest',
	#superclass : 'PBTDataFrameTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTDataFramePerfuzzWithTreeGrammarMutationTest >> csvGenerator [

	^ PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: self seed);
		  mutationsPerIteration: 3;
		  mutators: { (PBTTreeGrammarMutator from: CSVGrammar new) };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTDataFramePerfuzzWithTreeGrammarMutationTest >> setUp [ 

	super setUp.
	runner := PBTRunner test: DataFrame class >> #readFromCsv: from: schema for: 5 minutes.

]

{ #category : 'tests' }
PBTDataFramePerfuzzWithTreeGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
