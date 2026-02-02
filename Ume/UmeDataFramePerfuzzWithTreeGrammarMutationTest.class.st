Class {
	#name : 'UmeDataFramePerfuzzWithTreeGrammarMutationTest',
	#superclass : 'UmeDataFrameTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeDataFramePerfuzzWithTreeGrammarMutationTest >> csvGenerator [

	^ PBTCorpusGenerator new
		  seeds: { self seed };
		  mutationsPerIteration: 3;
		  mutators: {
				(PBTGrammarDerivationMutator from: CSVGrammar new) maxInputSize: 200
		  };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
UmeDataFramePerfuzzWithTreeGrammarMutationTest >> setUp [ 

	super setUp.
	runner := PBTRunner test: DataFrame class >> #readFromCsv: from: schema for: 1.5 hours.

]

{ #category : 'tests' }
UmeDataFramePerfuzzWithTreeGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
