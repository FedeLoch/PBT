Class {
	#name : 'PBTMicrodownPerfuzzWithGrammarMutatorTest',
	#superclass : 'PBTMicrodownTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTMicrodownPerfuzzWithGrammarMutatorTest >> markdownGenerator [

	^ PBTCorpusWithMutationsGenerator new
		  seeds: { self seed };
		  mutationsPerIteration: 100;
		  mutators: {
				(PBTGrammarLiteralsMutator from: ExtendedMarkdownGrammar new)
			};
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTMicrodownPerfuzzWithGrammarMutatorTest >> setUp [

	super setUp.
	runner := PBTRunner test: Microdown class >> #parse: from: schema for: 5 minutes.
]

{ #category : 'tests' }
PBTMicrodownPerfuzzWithGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
