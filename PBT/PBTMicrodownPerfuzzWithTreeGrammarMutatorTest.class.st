Class {
	#name : 'PBTMicrodownPerfuzzWithTreeGrammarMutatorTest',
	#superclass : 'PBTMicrodownTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTMicrodownPerfuzzWithTreeGrammarMutatorTest >> markdownGenerator [

	^ PBTCorpusWithMutationsGenerator new
		  seeds: { self seed };
		  mutationsPerIteration: 100;
		  mutators: { (PBTGrammarDerivationMutator from: ExtendedMarkdownGrammar new) maxInputSize: 200 };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTMicrodownPerfuzzWithTreeGrammarMutatorTest >> setUp [

	super setUp.
	runner := PBTRunner test: Microdown class >> #parse: from: schema for: 5 minutes.
]

{ #category : 'tests' }
PBTMicrodownPerfuzzWithTreeGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
