Class {
	#name : 'UmeMicrodownPerfuzzWithTreeGrammarMutatorTest',
	#superclass : 'UmeMicrodownTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeMicrodownPerfuzzWithTreeGrammarMutatorTest >> markdownGenerator [

	^ PBTCorpusGenerator new
		  seeds: { self seed };
		  mutationsPerIteration: 100;
		  mutators: { (PBTGrammarDerivationMutator from: ExtendedMarkdownGrammar new) maxInputSize: 200 };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
UmeMicrodownPerfuzzWithTreeGrammarMutatorTest >> setUp [

	super setUp.
	runner := PBTRunner test: Microdown class >> #parse: from: schema for: 5 minutes.
]

{ #category : 'tests' }
UmeMicrodownPerfuzzWithTreeGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
