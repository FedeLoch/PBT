Class {
	#name : 'FeedbackEvaluator',
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
FeedbackEvaluator >> eval: current [
	
	| newValue prevBetter feedback |

	newValue := self value: current.
	
	prevBetter := better.

	better ifNil: [ better := current. betterValue := newValue ].
	
	feedback := newValue >= betterValue.
	
	feedback ifTrue: [ better := current. betterValue := newValue ].
	
	^ Feedback having: prevBetter current: current with: newValue isBetter: feedback
]

{ #category : 'accessing' }
FeedbackEvaluator >> value: pbtCase [
	
	^ criteria value: pbtCase
]
