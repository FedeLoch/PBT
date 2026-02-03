Class {
	#name : 'UmeObjectGenerator',
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
UmeObjectGenerator >> feed: feedback [

	"do nothing"
]

{ #category : 'as yet unclassified' }
UmeObjectGenerator >> gen: myConstraint [
	
	^ then value: objectClass new value: myConstraint props
]

{ #category : 'accessing' }
UmeObjectGenerator >> objectClass [

	^ objectClass
]

{ #category : 'accessing' }
UmeObjectGenerator >> objectClass: aClass [

	objectClass := aClass 
]

{ #category : 'accessing' }
UmeObjectGenerator >> then: aBlock [

	then := aBlock 
]
