Class {
	#name : 'StringGrammar',
	#superclass : 'GenericGrammar',
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
StringGrammar >> defineGrammar [

	super defineGrammar.
	ntRoot --> ntString.
	
	^ ntRoot 
]
