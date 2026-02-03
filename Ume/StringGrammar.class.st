Class {
	#name : 'StringGrammar',
	#superclass : 'GenericGrammar',
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
StringGrammar >> defineGrammar [

	super defineGrammar.
	ntRoot --> ntString.
	
	^ ntRoot 
]
