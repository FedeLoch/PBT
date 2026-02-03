Class {
	#name : 'ConstantGrammar',
	#superclass : 'GenericGrammar',
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
ConstantGrammar >> defineGrammar [

	super defineGrammar.
	
	ntRoot --> '42'.

	^ ntRoot
]
