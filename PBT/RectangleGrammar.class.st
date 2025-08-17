Class {
	#name : 'RectangleGrammar',
	#superclass : 'GenericGrammar',
	#instVars : [
		'ntRectangle'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
RectangleGrammar >> defineGrammar [

	super defineGrammar.
	
	ntRoot  --> ntRectangle.
	
	ntRectangle --> 'origin:', ntPoint, 'corner:', ntPoint.

	^ ntRoot
]
