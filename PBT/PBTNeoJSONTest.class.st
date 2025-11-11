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
		self corpusGenFrom: '{"n":true,"n":[],"x":6}' mpi: 3 mutators: {
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
PBTNeoJSONTest >> test_17685504 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"n":true,"n":[],"x":6}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_219223552 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"lb":[[0,{},"c",""]],"":"r"}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_305008640 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"":false,"a":78,"gn":[false]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_309022464 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"c":[[82,["",{"s":"hb"},{"ux":true,"":{"":{"ew":{}},"":{"":null}},"":false}],"f",{"t":"es"},3]]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_315405568 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"lb":[[1,{},"u","","",{"mh":"h"},{}]],"j":{"":140}}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_395102720 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"c":[[82,["",{"aea":"wq"},{"t":"e"}],"f","","",[[]],{}]]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_447708672 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"jcrj":[[["v"],{},"w","","",[[]],[],false]],"i":[]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_592790528 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"c":[[82,["",{"s":"hb"},{"ux":true,"":{"":{"ew":{}},"":{"":null}},"":false}],"ev",{"t":"es"},3]]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_748935936 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"lb":[[4,{},"c",""]],"j":{"":"iw"}}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_757573888 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"c":[[82,["",{"s":"hb"},{"ux":true,"":{"":{"ew":{}},"":{"":null}},"":false}],{"":false},{},null]]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_759742720 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"lb":[[[]]],"":"r"}'].
		} asDictionary
	
]
