Class {
	#name : 'FeedbackEvaluator',
	#superclass : 'Object',
	#instVars : [
		'criteria',
		'better'
	],
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'instance creation' }
FeedbackEvaluator class >> from: aBlock [

	^ self new criteria: aBlock 
]

{ #category : 'accessing' }
FeedbackEvaluator >> criteria [

	^ criteria 
]

{ #category : 'accessing' }
FeedbackEvaluator >> criteria: aBlock [

	criteria := aBlock 
]

{ #category : 'accessing' }
FeedbackEvaluator >> eval: pbtCase [
	
	| newEval feedback |
	"TODO: this compare with the last better result"
	newEval := criteria value: pbtCase.
	feedback := better isNotNil and: [ newEval > better ].
	better ifNil: [ newEval ] ifNotNil: [ better max: newEval ].
	
	^ feedback
]
