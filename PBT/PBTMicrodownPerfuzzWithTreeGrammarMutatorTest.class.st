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

	| seed |
	seed := '# Header'.

	^ PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: seed);
		  mutationsPerIteration: 100;
		  mutators: { (PBTTreeGrammarMutator from: ExtendedMarkdownGrammar new mutationProbability: 10) };
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTMicrodownPerfuzzWithTreeGrammarMutatorTest >> setUp [

	super setUp.
	runner := PBTRunner test: Microdown class >> #parse: from: schema for: 1 minutes.
]

{ #category : 'tests' }
PBTMicrodownPerfuzzWithTreeGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
