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
	super generateTests: 5 minutes
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
FLSerializerPerformancePBTTest >> test_175727872 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[''t'':878,nil:5251,''a'':''sfwe'',nil:2],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/631.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_39343872 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[nil:''elqy'',''u'':nil,nil:nil,''ij'':780,''va'':nil,''cxl'':''b'',''v'':nil,''mobw'':7,nil:nil,nil:4,nil:nil],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/1581.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_409615104 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[nil:22,nil:''nij'',nil:nil,''sw'':6,nil:275,''n'':3,''m'':82],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/119.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_496954112 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[nil:nil,nil:''j'',''i'':nil,''fji'':nil,nil:nil,nil:nil,nil:nil,nil:90,''eh'':''h'',''poeij'':nil],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/212.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_540409600 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[''i'':''nim'',''l'':''tr''],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/4.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_636126976 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[nil:''o'',nil:nil,''i'':0],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/3.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_747278592 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[''gmg'':''u'',''v'':''tau'',''i'':''yad'',''t'':''nif'',nil:''jd'',''ucji'':7,nil:''w'',''dhq'':''d''],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/937.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_913094912 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[nil:4],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/1.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_971895040 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[''rha'':8,''m'':498986,nil:nil,nil:''mnht'',nil:4,''t'':nil],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/9.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_991260416 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[''azv'':''y'',''sgea'':nil,nil:1,''h'':0,nil:2,''xr'':4,''gw'':97],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/998.fuel'']'.
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
FLSerializerPerformancePBTTest >> test_994010368 [
	
		self doTest: {
			'method' -> (FLSerializer class>>#serialize:toFileNamed:) selector.
			'receiver' -> 'Class[#FLSerializer]'.
			'arguments' -> '[[nil:nil,nil:nil,nil:3,nil:8570,nil:nil,''r'':9,nil:''jvgkor'',nil:''b''],''/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/60.fuel'']'.
		} asDictionary
	
]
