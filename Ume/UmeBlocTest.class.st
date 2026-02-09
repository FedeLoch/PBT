Class {
	#name : 'UmeBlocTest',
	#superclass : 'UmeUnitTest',
	#category : 'Ume-Unit Testing Integration',
	#package : 'Ume',
	#tag : 'Unit Testing Integration'
}

{ #category : 'running' }
UmeBlocTest >> argumentGenerators [

	| seedElement |
	
	seedElement := BlElement new background: Color blue; extent: 50@50.

	^ {
		self corpusGenFrom: seedElement mpi: 3 mutators: {
			UmeGrammarDerivationMutator from: MateBlocGrammarByLang new
		}
	}
]

{ #category : 'running' }
UmeBlocTest >> assert: receiver arguments: arguments result: result [

	"let's pass all cases for the moment"
	^ true
]

{ #category : 'running' }
UmeBlocTest >> generateTests [

	<script: 'self new generateTests'>
	super generateTests: 30 minutes
]

{ #category : 'running' }
UmeBlocTest >> guidedBy [

	self guidedByMethodsCalls
	"self guidedByBytecodes" 
]

{ #category : 'running' }
UmeBlocTest >> receiverGenerator [ 

	^ self constantGen: UmeBlocRender
]

{ #category : 'running' }
UmeBlocTest >> targetMethod [

	^ UmeBlocRender class >> #render: 
]
