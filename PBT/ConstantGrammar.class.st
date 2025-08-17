Class {
	#name : 'ConstantGrammar',
	#superclass : 'GenericGrammar',
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
ConstantGrammar >> defineGrammar [

	super defineGrammar.
	
	ntRoot  --> '42'.

	^ ntRoot
]
