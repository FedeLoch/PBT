Class {
	#name : 'RectangleGrammar',
	#superclass : 'GenericGrammar',
	#instVars : [
		'ntRectangle'
	],
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
RectangleGrammar >> defineGrammar [

	super defineGrammar.
	
	ntRoot  --> ntRectangle.
	
	ntRectangle --> 'origin:', ntPoint, 'corner:', ntPoint.

	^ ntRoot
]
