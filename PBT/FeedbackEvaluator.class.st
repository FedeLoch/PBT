Class {
	#name : 'FeedbackEvaluator',
	#superclass : 'Object',
	#instVars : [
		'criteria',
		'lastEval'
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
FeedbackEvaluator >> compareWith: newEval [

	"Support other comparations"
	^ newEval >= lastEval
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
	
	newEval := criteria value: pbtCase.
	feedback := lastEval ifNil: [ true ] ifNotNil: [ self compareWith: newEval ].
	lastEval := feedback ifTrue: [ newEval ] ifFalse: [ lastEval ].
	
	^ feedback
]
