Class {
	#name : 'PBTObjectGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'then'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTObjectGenerator >> gen: myConstraint [
	
	^ then value: (myConstraint objectClass new) value: myConstraint props
]

{ #category : 'accessing' }
PBTObjectGenerator >> then: aBlock [

	then := aBlock 
]
