Class {
	#name : 'Person',
	#superclass : 'Object',
	#instVars : [
		'age',
		'name'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
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
