Class {
	#name : 'PersonGrammar',
	#superclass : 'GenericGrammar',
	#instVars : [
		'ntPerson',
		'ntAge',
		'ntName'
	],
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'as yet unclassified' }
PersonGrammar >> defineGrammar [

	super defineGrammar.
	
	ntRoot  --> ntPerson.
	
	ntPerson --> 'age:', ntAge, 'name:', ntName.
	
	ntAge --> 'age:', ntInteger.
	
	ntName --> 'name:', ntString. 

	^ ntRoot
]
