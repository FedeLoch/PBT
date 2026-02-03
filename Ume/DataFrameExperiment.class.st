Class {
	#name : 'DataFrameExperiment',
	#superclass : 'GrammarBasePathologicalBugMutatorPaperExperiment',
	#category : 'Ume-Paper Experimentation',
	#package : 'Ume',
	#tag : 'Paper Experimentation'
}

{ #category : 'running' }
DataFrameExperiment >> maxInputSize [

	^ 200
]

{ #category : 'running' }
DataFrameExperiment >> name [

	^ 'DataFrame'
]

{ #category : 'running' }
DataFrameExperiment >> newGrammar [

	^ CSVGrammar new
]

{ #category : 'running' }
DataFrameExperiment >> schemaCorpusWith: mutators [

	| csvGenerator |
	
	csvGenerator := UmeCorpusGenerator new
		  seeds: self seeds deepCopy;
		  mutationsPerIteration: self mpi;
		  mutators: mutators;
		  heuristic: UmePickBestElementDifferenceHeuristic new.
	
	^ UmeSchema new
		  receiverConstraint: (UmeObjectConstraint new generator: (UmeConstantGenerator new value: DataFrame));
		  argumentConstraints: { (UmeObjectConstraint new
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

{ #category : 'running' }
DataFrameExperiment >> seeds [

	^ { 'a' . 'id,first_name,last_name,email,gender,ip_address
1,Jeannine,Sutehall,jsutehall0@lulu.com,Female,250.29.137.240
2,Lynnette,Pashbee,lpashbee1@blogger.com,Female,179.86.141.239
3,Garrick,Fontell,gfontell2@sitemeter.com,Male,4.57.36.151
4,Osbert,O''Henecan,oohenecan3@senate.gov,Male,251.160.81.243
5,Doug,Vieyra,dvieyra4@chronoengine.com,Genderfluid,72.234.190.220' }
]

{ #category : 'running' }
DataFrameExperiment >> targetMethod [

	^ DataFrame class >> #readFromCsv:
]

{ #category : 'running' }
DataFrameExperiment >> weightedGrammarSchema [

	| csvGenerator |
	
	csvGenerator := UmeGrammarGenerator new grammar: self newGrammar; maxSize: self maxInputSize.
	
	^ UmeSchema new
		  receiverConstraint: (UmeObjectConstraint new generator: (UmeConstantGenerator new value: DataFrame));
		  argumentConstraints: { (UmeObjectConstraint new
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
