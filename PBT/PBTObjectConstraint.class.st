Class {
	#name : 'PBTObjectConstraint',
	#superclass : 'Object',
	#instVars : [
		'objectClass',
		'generator',
		'props'
	],
	#category : 'PBT-Property Specifcation',
	#package : 'PBT',
	#tag : 'Property Specifcation'
}

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> gen [

	^ generator gen: self
]

{ #category : 'accessing' }
PBTObjectConstraint >> generator [

	^ generator 
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> generator: aBlock [

	generator := aBlock
]

{ #category : 'accessing' }
PBTObjectConstraint >> objectClass [

	^ objectClass 
]

{ #category : 'accessing' }
PBTObjectConstraint >> objectClass: aClass [

	objectClass := aClass 
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> props [
	
	^ props
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> props: internalProperties [

	props := internalProperties
]
