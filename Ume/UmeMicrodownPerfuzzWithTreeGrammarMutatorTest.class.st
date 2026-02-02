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

	^ UmeCorpusGenerator new
		  seeds: { self seed };
		  mutationsPerIteration: 100;
		  mutators: { (UmeGrammarDerivationMutator from: ExtendedMarkdownGrammar new) maxInputSize: 200 };
		  heuristic: UmePickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
UmeMicrodownPerfuzzWithTreeGrammarMutatorTest >> setUp [

	super setUp.
	runner := UmeRunner test: Microdown class >> #parse: from: schema for: 5 minutes.
]

{ #category : 'tests' }
UmeMicrodownPerfuzzWithTreeGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
