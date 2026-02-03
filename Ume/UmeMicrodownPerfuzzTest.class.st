Class {
	#name : 'UmeMicrodownPerfuzzTest',
	#superclass : 'UmeMicrodownTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeMicrodownPerfuzzTest >> markdownGenerator [

	^ UmeCorpusGenerator new
		  seeds: { self seed };
		  "mutationsPerIteration: 200;"
		  mutators: {
				  UmeAddByteMutator new.
				  UmeByteFlipMutator new.
				  UmeDelByteMutator new
			};
		  heuristic: UmePickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
UmeMicrodownPerfuzzTest >> setUp [

	super setUp.
	runner := UmeRunner test: Microdown class >> #parse: from: schema for: 5 minutes.
]

{ #category : 'tests' }
UmeMicrodownPerfuzzTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
