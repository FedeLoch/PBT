Class {
	#name : 'DateGrammar',
	#superclass : 'GenericGrammar',
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
DateGrammar >> defineGrammar [

	super defineGrammar.
	ntRoot --> ntDate.
	
	^ ntRoot 
]
