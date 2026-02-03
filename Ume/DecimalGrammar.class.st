Class {
	#name : 'DecimalGrammar',
	#superclass : 'GenericGrammar',
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
DecimalGrammar >> defineGrammar [

	super defineGrammar.
	ntRoot --> ntDecimal.
	
	^ ntRoot 
]
