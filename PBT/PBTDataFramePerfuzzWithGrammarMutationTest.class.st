Class {
	#name : 'PBTDataFramePerfuzzWithGrammarMutationTest',
	#superclass : 'PBTDataFrameTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTDataFramePerfuzzWithGrammarMutationTest >> csvGenerator [

	^ PBTCorpusWithMutationsGenerator new
		  seeds: { self seed };
		  mutationsPerIteration: 10;
		  mutators: { (PBTGrammarLiteralsMutator from: CSVGrammar new) };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTDataFramePerfuzzWithGrammarMutationTest >> setUp [ 

	super setUp.
	runner := PBTRunner test: DataFrame class >> #readFromCsv: from: schema for: 5 minutes.

]

{ #category : 'tests' }
PBTDataFramePerfuzzWithGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
