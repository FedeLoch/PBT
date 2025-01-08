Class {
	#name : 'PBTObjectGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'then'
	],
	#category : 'PBT-Input Generation',
	#package : 'PBT',
	#tag : 'Input Generation'
}

{ #category : 'as yet unclassified' }
PBTObjectGenerator >> gen: myConstraint [
	
	^ then value: (myConstraint objectClass new) value: (myConstraint props asDictionary)
]

{ #category : 'accessing' }
PBTObjectGenerator >> then: aBlock [

	then := aBlock 
]
