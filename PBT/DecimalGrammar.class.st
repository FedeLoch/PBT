Class {
	#name : 'DecimalGrammar',
	#superclass : 'GenericGrammar',
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
DecimalGrammar >> defineGrammar [

	super defineGrammar.
	ntRoot --> ntDecimal.
	
	^ ntRoot 
]
