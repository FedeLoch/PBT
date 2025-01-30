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
	
	newEval := criteria value: pbtCase.
	better ifNil: [ better := newEval ].
	
	feedback := newEval >= better.
	better := (better / 2) max: newEval.
	
	^ feedback
]
