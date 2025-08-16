Class {
	#name : 'PersonGrammar',
	#superclass : 'GenericGrammar',
	#instVars : [
		'ntPerson',
		'ntAge',
		'ntName'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
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
