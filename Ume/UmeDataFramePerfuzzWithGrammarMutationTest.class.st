Class {
	#name : 'UmeDataFramePerfuzzWithGrammarMutationTest',
	#superclass : 'UmeDataFrameTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeDataFramePerfuzzWithGrammarMutationTest >> csvGenerator [

	^ PBTCorpusGenerator new
		  seeds: { self seed };
		  mutationsPerIteration: 10;
		  mutators: { (PBTGrammarLiteralsMutator from: CSVGrammar new) };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
UmeDataFramePerfuzzWithGrammarMutationTest >> setUp [ 

	super setUp.
	runner := PBTRunner test: DataFrame class >> #readFromCsv: from: schema for: 5 minutes.

]

{ #category : 'tests' }
UmeDataFramePerfuzzWithGrammarMutationTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
