Class {
	#name : 'Feedback',
	#superclass : 'Object',
	#instVars : [
		'previous',
		'current',
		'value',
		'feedback'
	],
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
Feedback class >> having: prev current: pbtCase with: value isBetter: feedback [

	^ self new previous: prev; current: pbtCase; value: value; feedback: feedback
]

{ #category : 'accessing' }
Feedback >> current [

	^ current
]

{ #category : 'accessing' }
Feedback >> current: pbtCase [

	current := pbtCase
]

{ #category : 'accessing' }
Feedback >> feedback [

	^ feedback 
]

{ #category : 'accessing' }
Feedback >> feedback: someFeedback [
	
	feedback := someFeedback 
]

{ #category : 'accessing' }
Feedback >> previous [

	^ previous 
]

{ #category : 'accessing' }
Feedback >> previous: prev [

	previous := prev
]

{ #category : 'accessing' }
Feedback >> value [

	^ value
]

{ #category : 'accessing' }
Feedback >> value: aValue [

	value := aValue
]
