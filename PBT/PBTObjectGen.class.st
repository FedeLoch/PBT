Class {
	#name : 'PBTObjectGen',
	#superclass : 'PBTGen',
	#instVars : [
		'then'
	],
	#category : 'PBT-Input Generation',
	#package : 'PBT',
	#tag : 'Input Generation'
}

{ #category : 'as yet unclassified' }
PBTObjectGen >> gen: myConstraint [
	
	^ then value: (myConstraint objectClass new) value: (myConstraint props asDictionary)
]

{ #category : 'accessing' }
PBTObjectGen >> then: aBlock [

	then := aBlock 
]
