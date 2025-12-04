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
	super generateTests: 20 minutes
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

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_1007382784 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[nil:6,nil:5,nil:36,nil:602,nil:4,nil:20,nil:''a'',''t'':2],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/3222.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_149707520 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[''x'':490496,''bd'':38,''wa'':94,''oew'':nil,nil:nil,nil:nil,nil:3,nil:93313,nil:nil,''c'':''lqm'',nil:nil,nil:nil,nil:nil,nil:nil],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/5.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_275986176 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[nil:nil,nil:''d'',nil:''t'',''m'':nil,nil:nil,''phx'':nil,''q'':nil,nil:nil,nil:''o'',nil:nil,''bb'':''hp'',nil:''qi'',''l'':nil,nil:''x'',''ekfs'':8,''j'':36374],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/5999.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_303698176 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[''o'':nil],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/1.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_329486080 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[''r'':''xuzgjlt'',nil:15,nil:nil,''pmuhc'':nil,nil:nil,nil:''a'',''i'':nil,''bg'':''q'',''qoxpja'':94,''u'':''xc'',''sj'':1],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/3252.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_53232896 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[''v'':47,nil:2,nil:''u''],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/3.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_778423040 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[nil:''eu'',nil:766,nil:4,''p'':668,''n'':95],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/519.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_779191552 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[nil:''h'',nil:nil,''afh'':''k'',nil:1,nil:9,''a'':''ymk'',''j'':8,nil:nil,nil:nil,''fcl'':2,''n'':975452,''k'':30],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/1641.fuel'']'.
		} asDictionary
	
]
