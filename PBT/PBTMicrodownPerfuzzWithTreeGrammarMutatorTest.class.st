Class {
	#name : 'PBTMicrodownPerfuzzWithTreeGrammarMutatorTest',
	#superclass : 'PBTMicrodownTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTMicrodownPerfuzzWithTreeGrammarMutatorTest >> markdownGenerator [

	^ PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: self seed);
		  mutationsPerIteration: 10;
		  mutators: { (PBTTreeGrammarMutator from: ExtendedMarkdownGrammar new mutationProbability: 5) };
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
