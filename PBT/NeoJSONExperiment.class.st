Class {
	#name : 'NeoJSONExperiment',
	#superclass : 'GrammarBasePathologicalBugExperiment',
	#category : 'PBT-Paper Experimentation',
	#package : 'PBT',
	#tag : 'Paper Experimentation'
}

{ #category : 'running' }
NeoJSONExperiment >> maxInputSize [

	^ 100
]

{ #category : 'running' }
NeoJSONExperiment >> name [

	^ 'NeoJSON'
]

{ #category : 'running' }
NeoJSONExperiment >> newGrammar [

	^ JSONGrammar new
]

{ #category : 'running' }
NeoJSONExperiment >> schema: seed mutators: mutators mutationsPerIteration: n [

	| receiverConstraint argumentConstraints jsonGenerator |
	
	jsonGenerator := PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: seed);
		  mutationsPerIteration: n;
		  mutators: mutators;
		  heuristic: PBTPickBestElementDifferenceHeuristic new.
	
	receiverConstraint := PBTObjectConstraint new generator: (PBTConstantGenerator new value: NeoJSONReader).
	argumentConstraints := { PBTObjectConstraint new objectClass: String; generator: jsonGenerator }.

	^ PBTSchema new
		receiverConstraint: receiverConstraint;
		argumentConstraints: argumentConstraints;
		assert: [ :regex :input :result | true ].
]

{ #category : 'running' }
NeoJSONExperiment >> seeds [

	^ { '{}' . '{"n":true,"n":[],"x":6}' }
]

{ #category : 'running' }
NeoJSONExperiment >> targetMethod [

	^ NeoJSONReader class >> #fromString:
]
