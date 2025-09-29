Class {
	#name : 'PBTFeedback',
	#superclass : 'Object',
	#instVars : [
		'case',
		'feedback',
		'improvement'
	],
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
PBTFeedback class >> from: case improvement: improvement [

	^ self new case: case; feedback: improvement > 0; improvement: improvement
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

{ #category : 'accessing' }
PBTFeedback >> improvement [

	^ improvement
]

{ #category : 'accessing' }
PBTFeedback >> improvement: anImprovement [

	improvement := anImprovement
]

{ #category : 'accessing' }
PBTFeedback >> isPositive [

	^ feedback
]
