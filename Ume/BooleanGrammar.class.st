Class {
	#name : 'BooleanGrammar',
	#superclass : 'GenericGrammar',
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
BooleanGrammar >> defineGrammar [

	super defineGrammar.
	ntRoot --> ntBoolean.
	
	^ ntRoot 
]
