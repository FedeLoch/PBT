Class {
	#name : 'DateGrammar',
	#superclass : 'GenericGrammar',
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
DateGrammar >> defineGrammar [

	super defineGrammar.
	ntRoot --> ntDate.
	
	^ ntRoot 
]
