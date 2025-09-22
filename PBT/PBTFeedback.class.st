Class {
	#name : 'PBTFeedback',
	#superclass : 'Object',
	#instVars : [
		'case',
		'feedback'
	],
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
PBTFeedback class >> from: case value: isPositive [

	^ self new case: case; feedback: isPositive
]

{ #category : 'accessing' }
PBTFeedback >> case [

	^  case
]

{ #category : 'accessing' }
PBTFeedback >> case: aCase [
	
	case := aCase 
]

{ #category : 'accessing' }
PBTFeedback >> feedback [

	^ feedback 
]

{ #category : 'accessing' }
PBTFeedback >> feedback: someFeedback [
	
	feedback := someFeedback 
]
