Class {
	#name : 'PBTObjectGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'then',
		'objectClass'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTObjectGenerator >> gen: myConstraint [
	
	^ then value: objectClass new value: myConstraint props
]

{ #category : 'accessing' }
PBTObjectGenerator >> objectClass [

	^ objectClass
]

{ #category : 'accessing' }
PBTObjectGenerator >> objectClass: aClass [

	objectClass := aClass 
]

{ #category : 'accessing' }
PBTObjectGenerator >> then: aBlock [

	then := aBlock 
]
