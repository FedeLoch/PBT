Class {
	#name : 'Person',
	#superclass : 'Object',
	#instVars : [
		'age',
		'name'
	],
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'accessing' }
Person >> age [

	^ age
]

{ #category : 'accessing' }
Person >> age: aNumber [

	age := aNumber 
]

{ #category : 'accessing' }
Person >> name: aName [

	name := aName 
]
