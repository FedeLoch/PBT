Class {
	#name : 'PBTMicrodownPerfuzzTest',
	#superclass : 'PBTMicrodownTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTMicrodownPerfuzzTest >> markdownGenerator [

	^ PBTCorpusWithMutationsGenerator new
		  seeds: { self seed };
		  "mutationsPerIteration: 200;"
		  mutators: {
				  PBTAddByteMutator new.
				  PBTByteFlipMutator new.
				  PBTDelByteMutator new
			};
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTMicrodownPerfuzzTest >> setUp [

	super setUp.
	runner := PBTRunner test: Microdown class >> #parse: from: schema for: 5 minutes.
]

{ #category : 'tests' }
PBTMicrodownPerfuzzTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
