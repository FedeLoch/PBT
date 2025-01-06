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

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> gen: aBlock [

	generator := aBlock
]

{ #category : 'accessing' }
PBTObjectConstraint >> objectClass: aClass [

	objectClass := aClass 
]
