Class {
	#name : 'PBTObjectConstraint',
	#superclass : 'Object',
	#instVars : [
		'objectClass',
		'generator',
		'props'
	],
	#category : 'PBT-Property Schema',
	#package : 'PBT',
	#tag : 'Property Schema'
}

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> gen [

	^ generator gen: self
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> genBy: aFeedback [

	^ generator gen: self by: aFeedback
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
