Class {
	#name : 'AssociationsGrammar',
	#superclass : 'GncGrammar',
	#instVars : [
		'ntAssociations',
		'ntAssociation',
		'ntKey',
		'ntValue',
		'ntString',
		'ntInteger'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'initialization' }
AssociationsGrammar >> defineGrammar [

	ntAssociations --> ntAssociation | ntAssociation, Character cr asString, ntAssociations.
	
	ntAssociation  --> ntKey, '->', ntValue.
	
	ntKey          --> 'nil' | ntString.
	
	ntValue        -->  ntString | ntInteger | 'nil'.
	
	ntString       --> ($a - $z), ntString | ($a - $z).
		
	ntInteger      --> ($0 - $9) | ($0 - $9), ntInteger.
	
	^ ntAssociations 
]
