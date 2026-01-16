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

	^ PBTCorpusGenerator new
		  seeds: { self seed };
		  mutationsPerIteration: 3;
		  mutators: { (PBTGrammarDerivationMutator from: CSVGrammar new) maxInputSize: 200 };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTDataFramePerfuzzWithTreeGrammarMutationTest >> setUp [ 

	super setUp.
	runner := PBTRunner test: DataFrame class >> #readFromCsv: from: schema for: 2 minutes.

]

{ #category : 'tests' }
PBTDataFramePerfuzzWithTreeGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
