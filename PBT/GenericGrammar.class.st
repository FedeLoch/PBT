Class {
	#name : 'GenericGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntInteger',
		'ntString',
		'ntRoot'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
GenericGrammar >> defineGrammar [

	ntString --> ($a - $z), ntString | ($a - $z).
	
	ntInteger --> ($0 - $9), ($0 - $9).
	
	^ ntRoot 
]
