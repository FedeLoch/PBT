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
		  seedGenerator: (PBTConstantGenerator new value: self seed);
		  mutationsPerIteration: 100;
		  mutators: { (PBTTreeGrammarMutator from: ExtendedMarkdownGrammar new) };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTMicrodownPerfuzzWithTreeGrammarMutatorTest >> setUp [

	super setUp.
	runner := PBTRunner test: Microdown class >> #parse: from: schema for: 30 minutes.
]

{ #category : 'tests' }
PBTMicrodownPerfuzzWithTreeGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
