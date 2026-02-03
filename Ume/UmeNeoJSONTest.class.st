Class {
	#name : 'UmeNeoJSONTest',
	#superclass : 'UmeUnitTest',
	#category : 'Ume-Unit Testing Integration',
	#package : 'Ume',
	#tag : 'Unit Testing Integration'
}

{ #category : 'running' }
UmeNeoJSONTest >> argumentGenerators [

	^ {
		self corpusGenFrom: '[]' mpi: 3 mutators: {
			(UmeGrammarDerivationMutator from: JSONGrammar new) maxInputSize: 100
		}
	}
]

{ #category : 'running' }
UmeNeoJSONTest >> assert: receiver arguments: arguments result: result [

	^ (NeoJSONWriter toString: result) = arguments first 
]

{ #category : 'running' }
UmeNeoJSONTest >> generateTests [

	<script: 'self new generateTests'>
	super generateTests: 1 hour
]

{ #category : 'running' }
UmeNeoJSONTest >> guidedBy [

	"self guidedByMethodsCalls"
	self guidedByBytecodes 
]

{ #category : 'running' }
UmeNeoJSONTest >> receiverGenerator [ 

	^ self constantGen: NeoJSONReader
]

{ #category : 'running' }
UmeNeoJSONTest >> targetMethod [

	^ NeoJSONReader class >> #fromString:
]

{ #category : 'Ume dynamic tests' }
UmeNeoJSONTest >> test_474231552 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> '[''[[[[[[[[[[],"","r"],{"":null}],8,4],5,0],3,6],2,2],0,9],3,0],9,8]'']'.
		} asDictionary
	
]

{ #category : 'Ume dynamic tests' }
UmeNeoJSONTest >> test_594914560 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> '[''[[[[[[[[[[[[[[[[[4,7],5,5],5,7],4,8],8,7],7,4],6,2],0,8],4,1],5,6],8,4],9,0],3,6],2,2],0,9],3,0],9,8]'']'.
		} asDictionary
	
]

{ #category : 'Ume dynamic tests' }
UmeNeoJSONTest >> test_774203648 [
	
		self doTest: {
			'method' -> (NeoJSONReader class>>#fromString:) selector.
			'receiver' -> 'Class[#NeoJSONReader]'.
			'arguments' -> '[''[]'']'.
		} asDictionary
	
]
