Class {
	#name : 'DataFramePerfMetricsExperiment',
	#superclass : 'PerformanceMetricsPaperExperiment',
	#category : 'PBT-Paper Experimentation',
	#package : 'PBT',
	#tag : 'Paper Experimentation'
}

{ #category : 'running' }
DataFramePerfMetricsExperiment >> libraryName [

	^ 'DataFrame'
]

{ #category : 'running' }
DataFramePerfMetricsExperiment >> maxSize [

	^ 200
]

{ #category : 'running' }
DataFramePerfMetricsExperiment >> newGrammar [

	^ CSVGrammar new
]

{ #category : 'running' }
DataFramePerfMetricsExperiment >> schema [

	| csvGenerator |
	
	csvGenerator := PBTCorpusGenerator new
		  seedGenerator: (PBTConstantGenerator new value: self seed);
		  mutationsPerIteration: self mpi;
		  mutators: self mutators;
		  heuristic: PBTPickBestElementDifferenceHeuristic new.
	
	^ PBTSchema new
		  receiverConstraint: (PBTObjectConstraint new generator: (PBTConstantGenerator new value: DataFrame));
		  argumentConstraints: { (PBTObjectConstraint new
				   generator: csvGenerator;
				   wrap: [ :input |
						   | file |
						   file := FileLocator temp / input hash asString , '.csv'.
						   file ensureDelete.
						   file writeStreamDo: [ :stream | stream nextPutAll: input ].
						   file asFileReference ];
				   unwrap: #contents) };
		  assert: [ :regex :input :result | true ]
]

{ #category : 'accessing' }
DataFramePerfMetricsExperiment >> seed [

	^ 'id,first_name,last_name,email,gender,ip_address
1,Jeannine,Sutehall,jsutehall0@lulu.com,Female,250.29.137.240
2,Lynnette,Pashbee,lpashbee1@blogger.com,Female,179.86.141.239
3,Garrick,Fontell,gfontell2@sitemeter.com,Male,4.57.36.151
4,Osbert,O''Henecan,oohenecan3@senate.gov,Male,251.160.81.243
5,Doug,Vieyra,dvieyra4@chronoengine.com,Genderfluid,72.234.190.220'
]

{ #category : 'running' }
DataFramePerfMetricsExperiment >> targetMethod [

	^ DataFrame class >> #readFromCsv:
]
