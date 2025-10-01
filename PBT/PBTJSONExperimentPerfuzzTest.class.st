Class {
	#name : 'PBTJSONExperimentPerfuzzTest',
	#superclass : 'PBTJSONExperimentTest',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTJSONExperimentPerfuzzTest >> jsonGenerator [

	| mutator randomGenerator |
	
	randomGenerator := PBTGrammarGenerator new grammar: JSONGrammar new; maxHeight: 100; maxSize: 100.
	
	mutator := PBTMutator mutate: [ :input | | input2 |
		input2 := randomGenerator gen: nil.
		NeoJSONReader mutate: input with: input2
	].

	^ PBTCorpusWithMutationsGenerator new seedGenerator: randomGenerator; mutators: { mutator };
		heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'tests' }
PBTJSONExperimentPerfuzzTest >> testGuidingByMethodsCalls [ 

	| runner result |
	
	runner := (PBTRunner test: NeoJSONReader class >> #fromString: from: schema for: 10 minutes) guidedByMethodsCalls.
	result := runner run.
	
	self assert: (result tests size) equals: 10000.
]
