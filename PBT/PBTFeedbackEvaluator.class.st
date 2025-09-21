Class {
	#name : 'PBTFeedbackEvaluator',
	#superclass : 'Object',
	#instVars : [
		'criteria',
		'better',
		'betterValue'
	],
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'instance creation' }
PBTFeedbackEvaluator class >> from: aBlock [

	^ self new criteria: aBlock 
]

{ #category : 'ston-core' }
PBTFeedbackEvaluator class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( criteria )
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> criteria [

	^ criteria 
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> criteria: aBlock [

	criteria := aBlock 
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> eval: case [
	
	| newValue prevBetter feedback |
	1 halt.
	"Udpate this"
	newValue := self value: case.
	
	prevBetter := better.

	better ifNil: [ better := case. betterValue := newValue ].
	
	feedback := newValue >= betterValue.
	
	feedback ifTrue: [ better := case. betterValue := newValue ].
	
	^ PBTFeedback having: prevBetter current: case with: newValue isBetter: feedback
]
