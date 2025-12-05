Class {
	#name : 'FLSerializerPerformancePBTTest',
	#superclass : 'PBTUnitTest',
	#category : 'PBT-Unit Testing Integration',
	#package : 'PBT',
	#tag : 'Unit Testing Integration'
}

{ #category : 'running' }
FLSerializerPerformancePBTTest >> argumentGenerators [

	^ {
		self associationArrayGenerator.
		self pathGenerator.
	}
]

{ #category : 'running' }
FLSerializerPerformancePBTTest >> associationArrayGenerator [

	^ PBTAssociationParserGenerator from: (self corpusGenFrom: 'a->nil' mpi: 3 mutators: {
		(PBTTreeGrammarMutator from: AssociationsGrammar new) maxInputSize: 50000
	})
]

{ #category : 'running' }
FLSerializerPerformancePBTTest >> generateTests [

	"super generateRegressionTests: 10 minutes"
	<script: 'self new generateTests'>
	super generateRegressionTests: 1 minutes
]

{ #category : 'running' }
FLSerializerPerformancePBTTest >> guidedBy [

	"self guidedByMethodsCalls"
	self guidedByMethodsCalls 
]

{ #category : 'running' }
FLSerializerPerformancePBTTest >> pathGenerator [

	| n |
	n := 0.

	^ PBTGenerator do: [ :props :feedback | | file |
		n := n + 1.
		file := FileLocator imageDirectory / (n asString, '.fuel').
		file ensureDelete.
		file pathString
	]
]

{ #category : 'running' }
FLSerializerPerformancePBTTest >> receiverGenerator [ 

	^ self constantGen: FLSerializer
]

{ #category : 'running' }
FLSerializerPerformancePBTTest >> targetMethod [

	^ FLSerializer class >> #serialize:toFileNamed:
]
