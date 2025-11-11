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
PBTNeoJSONTest >> test_1065701376 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"uj":true,"":{"xmay":[[["m"]],"",59,null,null],"rx":[""],"vk":{},"h":{"v":null}},"":9,"k":{},"":false}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_1069832960 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"n":true,"n":[],"x":6}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_410537472 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"n":true,"n":[],"":[null]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_439378944 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"de":true,"dwy":{"f":4,"yg":1,"":"t","a":true},"":1}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_443656448 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"t":{"":[{"":[[]]},{"l":null},""]},"qe":[],"":[[{"":true},"","z",[[]]]],"z":[],"c":[[""],{},""]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_693326080 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"o":true,"j":{"j":7,"en":[""]},"":4}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_695895808 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"v":true,"li":[],"":5,"":[["",false,"xm","","p"],""]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_743581184 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"t":{"":[["",61352,true],{"j":null},""]},"z":[],"":[[[[[]]],""]]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_791460352 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"v":true,"li":[],"":5,"":[["",false,"xm",21,40,false,"","j"],""]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_799751168 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"cbv":189,"":{"":8,"czt":["",165260640,63],"af":{"":274},"":{"u":null}},"":true,"":32,"":null}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_802290944 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"uj":true,"":{"xmay":[[["m"]],"",621,709],"rx":[""],"vk":{},"h":{"v":null}},"":9,"k":{},"":false}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_888255232 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"uj":true,"":{"xmay":[[["m"]],"",59,null,null],"rx":[""],"vk":{},"h":{"v":null}},"":9,"jo":{},"":825,"":false}'].
		} asDictionary
	
]
