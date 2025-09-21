Class {
	#name : 'PBTFeedback',
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
PBTFeedback class >> having: prev current: pbtCase with: value isBetter: feedback [

	^ self new previous: prev; current: pbtCase; value: value; feedback: feedback
]

{ #category : 'accessing' }
PBTFeedback >> current [

	^ current
]

{ #category : 'accessing' }
PBTFeedback >> current: pbtCase [

	current := pbtCase
]

{ #category : 'accessing' }
PBTFeedback >> feedback [

	^ feedback 
]

{ #category : 'accessing' }
PBTFeedback >> feedback: someFeedback [
	
	feedback := someFeedback 
]

{ #category : 'accessing' }
PBTFeedback >> previous [

	^ previous 
]

{ #category : 'accessing' }
PBTFeedback >> previous: prev [

	previous := prev
]

{ #category : 'accessing' }
PBTFeedback >> value [

	^ value
]

{ #category : 'accessing' }
PBTFeedback >> value: aValue [

	value := aValue
]
