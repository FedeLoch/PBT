Class {
	#name : 'UmeMicrodownPerfuzzWithGrammarMutatorTest',
	#superclass : 'UmeMicrodownTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeMicrodownPerfuzzWithGrammarMutatorTest >> markdownGenerator [

	^ PBTCorpusGenerator new
		  seeds: { self seed };
		  mutationsPerIteration: 100;
		  mutators: {
				(PBTGrammarLiteralsMutator from: ExtendedMarkdownGrammar new)
			};
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
UmeMicrodownPerfuzzWithGrammarMutatorTest >> setUp [

	super setUp.
	runner := PBTRunner test: Microdown class >> #parse: from: schema for: 5 minutes.
]

{ #category : 'tests' }
UmeMicrodownPerfuzzWithGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
