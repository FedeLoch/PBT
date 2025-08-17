Class {
	#name : 'BooleanGrammar',
	#superclass : 'GenericGrammar',
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
BooleanGrammar >> defineGrammar [

	super defineGrammar.
	ntRoot --> ntBoolean.
	
	^ ntRoot 
]
