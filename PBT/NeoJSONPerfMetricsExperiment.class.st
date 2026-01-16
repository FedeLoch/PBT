Class {
	#name : 'NeoJSONPerfMetricsExperiment',
	#superclass : 'PerformanceMetricsPaperExperiment',
	#category : 'PBT-Paper Experimentation',
	#package : 'PBT',
	#tag : 'Paper Experimentation'
}

{ #category : 'running' }
NeoJSONPerfMetricsExperiment >> libraryName [

	^ 'NeoJSON'
]

{ #category : 'running' }
NeoJSONPerfMetricsExperiment >> maxSize [

	^ 100
]

{ #category : 'running' }
NeoJSONPerfMetricsExperiment >> newGrammar [

	^ JSONGrammar new
]

{ #category : 'running' }
NeoJSONPerfMetricsExperiment >> schema [ 

	| receiverConstraint argumentConstraints jsonGenerator |
	
	jsonGenerator := PBTCorpusGenerator new
		  seedGenerator: (PBTConstantGenerator new value: self seed);
		  mutationsPerIteration: self mpi;
		  mutators: self mutators;
		  heuristic: PBTPickBestElementDifferenceHeuristic new.
	
	receiverConstraint := PBTObjectConstraint new generator: (PBTConstantGenerator new value: NeoJSONReader).
	argumentConstraints := { PBTObjectConstraint new objectClass: String; generator: jsonGenerator }.

	^ PBTSchema new
		receiverConstraint: receiverConstraint;
		argumentConstraints: argumentConstraints;
		assert: [ :regex :input :result | true ].
]

{ #category : 'accessing' }
NeoJSONPerfMetricsExperiment >> seed [

	^ '{"n":true,"n":[],"x":6}'
]

{ #category : 'running' }
NeoJSONPerfMetricsExperiment >> targetMethod [

	^ NeoJSONReader class >> #fromString:
]
