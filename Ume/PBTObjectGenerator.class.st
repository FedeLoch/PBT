Class {
	#name : 'PBTObjectGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'then',
		'objectClass'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTObjectGenerator >> feed: feedback [

	"do nothing"
]

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
