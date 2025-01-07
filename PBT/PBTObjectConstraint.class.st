Class {
	#name : 'PBTObjectConstraint',
	#superclass : 'Object',
	#instVars : [
		'objectClass',
		'generator'
	],
	#category : 'PBT-Property Specifcation',
	#package : 'PBT',
	#tag : 'Property Specifcation'
}

{ #category : 'accessing' }
PBTObjectConstraint >> generator [

	^ generator 
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> generator: aBlock [

	generator := aBlock
]

{ #category : 'accessing' }
PBTObjectConstraint >> objectClass: aClass [

	objectClass := aClass 
]
