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
	super generateTests: 5 minutes
]

{ #category : 'running' }
PBTNeoJSONTest >> guidedBy [

	"self guidedByMethodsCalls"
	self guidedByBytecodes 
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
PBTNeoJSONTest >> test_46185472 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['["deh"]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_647473152 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"":[[[],true,"khd",[[]],{"":{"x":6,"uv":null,"m":[]},"d":"rdp"}]]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_651039232 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['["defg"]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_777496064 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[]'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_885481216 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['16'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_903861504 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['{"":[[[],true,"c",[[]],""]]}'].
		} asDictionary
	
]

{ #category : 'PBT dynamic tests' }
PBTNeoJSONTest >> test_943663360 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> ['[""]'].
		} asDictionary
	
]
