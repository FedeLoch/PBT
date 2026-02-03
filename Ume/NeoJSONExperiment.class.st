Class {
	#name : 'NeoJSONExperiment',
	#superclass : 'GrammarBasePathologicalBugMutatorPaperExperiment',
	#category : 'Ume-Paper Experimentation',
	#package : 'Ume',
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
NeoJSONExperiment >> schemaCorpusWith: mutators [

	| receiverConstraint argumentConstraints jsonGenerator |
	
	jsonGenerator := UmeCorpusGenerator new
		  seeds: self seeds deepCopy;
		  mutationsPerIteration: self mpi;
		  mutators: mutators;
		  heuristic: UmePickBestElementDifferenceHeuristic new.
	
	receiverConstraint := UmeObjectConstraint new generator: (UmeConstantGenerator new value: NeoJSONReader).
	argumentConstraints := { UmeObjectConstraint new objectClass: String; generator: jsonGenerator }.

	^ UmeSchema new
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

{ #category : 'running' }
NeoJSONExperiment >> weightedGrammarSchema [

	| receiverConstraint argumentConstraints jsonGenerator |
	
	jsonGenerator := UmeGrammarGenerator new grammar: self newGrammar; maxSize: self maxInputSize.
	receiverConstraint := UmeObjectConstraint new generator: (UmeConstantGenerator new value: NeoJSONReader).
	argumentConstraints := { UmeObjectConstraint new objectClass: String; generator: jsonGenerator }.

	^ UmeSchema new
		receiverConstraint: receiverConstraint;
		argumentConstraints: argumentConstraints;
		assert: [ :regex :input :result | true ].
]
