Class {
	#name : 'PBTJSONPerfuzzTest',
	#superclass : 'PBTJSONExperimentTest',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTJSONPerfuzzTest >> jsonGenerator [

	| mutator randomGenerator |
	
	randomGenerator := (PBTGrammarMCTSGenerator from: JSONGrammar new) maxSize: Float infinity.
	
	mutator := PBTMutator mutate: [ :input |
		NeoJSONReader mutate: input with: (randomGenerator gen: nil)
	].

	^ PBTCorpusWithMutationsGenerator new
		seedGenerator: (PBTConstantGenerator new value: '{}'); mutators: { mutator };
		heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'tests' }
PBTJSONPerfuzzTest >> testGuidingByMethodsCalls [ 

	| runner result |
	
	runner := (PBTRunner test: NeoJSONReader class >> #fromString: from: schema for: 15 minutes) guidedByMethodsCalls.
	result := runner run.
	
	self assert: (result tests size) equals: 10000.
]
