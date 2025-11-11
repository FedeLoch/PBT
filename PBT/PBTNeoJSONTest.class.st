Class {
	#name : 'PBTNeoJSONTest',
	#superclass : 'PBTUnitTest',
	#category : 'PBT-Unit Testing Integration',
	#package : 'PBT',
	#tag : 'Unit Testing Integration'
}

{ #category : 'running' }
PBTNeoJSONTest >> argumentGenerators [

	^ {
		self corpusGenFrom: '[]' mpi: 3 mutators: {
			(PBTTreeGrammarMutator from: JSONGrammar new) maxInputSize: 100
		}
	}
]

{ #category : 'running' }
PBTNeoJSONTest >> assert: receiver arguments: arguments result: result [

	^ (NeoJSONWriter toString: result) = arguments first 
]

{ #category : 'running' }
PBTNeoJSONTest >> generateTests [

	<script: 'self new generateTests'>
	super generateTests: 10 minutes
]

{ #category : 'running' }
PBTNeoJSONTest >> receiverGenerator [ 

	^ self constantGen: NeoJSONReader
]

{ #category : 'running' }
PBTNeoJSONTest >> targetMethod [

	^ NeoJSONReader class >> #fromString:
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_146323200 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['4'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_197470976 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[[{"":"ob"},""]]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_355585536 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[[[[[646562],"",0,062755],"vx",[["y"]],[503750],"",null],{},{},[1,null],["",[{"c":"f"}],[]]]]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_369663744 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[["z",{},{},[[0081],"",[{"k":4}]],null]]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_433265152 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[["pnf",{},{},[[936915],"",[[true,null]]],"mm"]]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_458894336 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[8]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_546047232 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[["pnf",{},{},[],"mm"]]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_605775360 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[["",{},{}]]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_635631872 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[["z",{},{},[[null],"",[["hxd",null]],[]],false]]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_68785152 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[["z",{},{},[[755126],"",[{"":"qiq","":"qeh"}],436796],null]]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_692307968 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[[[[[646562],"",0,062755],"vx",[[null,null,false]],[503750],"",null],{},{},[1,null],["",[{"c":"f"}],[]]]]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_755765504 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[[]]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_952308480 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[[[[[646562],"",0,062755],"vx",[["y"]],[503750],"",[]],{},{},[1,null],["",[{"c":"f"}],[]]]]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_959864832 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[["wxv",{},{},[49,""]]]'].
		} asDictionary
	
]
