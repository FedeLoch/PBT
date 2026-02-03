Class {
	#name : 'UmeFeedback',
	#superclass : 'Object',
	#instVars : [
		'case',
		'feedback',
		'improvement',
		'values',
		'score'
	],
	#category : 'Ume-Feedback',
	#package : 'Ume',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
UmeFeedback class >> from: case improvement: improvement values: values [

	^ self new case: case; feedback: improvement > 0; improvement: improvement; values: values
]

{ #category : 'accessing' }
UmeFeedback >> absoluteScore [

	^ self relevantValues inject: 0 into: [ :acc :key | key value + acc ]
]

{ #category : 'accessing' }
UmeFeedback >> case [

	^  case
]

{ #category : 'accessing' }
UmeFeedback >> case: aCase [
	
	case := aCase 
]

{ #category : 'accessing' }
UmeFeedback >> feedback [

	^ feedback 
]

{ #category : 'accessing' }
UmeFeedback >> feedback: someFeedback [
	
	feedback := someFeedback 
]

{ #category : 'accessing' }
UmeFeedback >> improvement [

	^ improvement
]

{ #category : 'accessing' }
UmeFeedback >> improvement: anImprovement [

	improvement := anImprovement
]

{ #category : 'accessing' }
UmeFeedback >> isPositive [

	^ feedback
]

{ #category : 'accessing' }
UmeFeedback >> relevantValues [

	^ values select: [ :k | k value ~= 0 ]
]

{ #category : 'accessing' }
UmeFeedback >> score [

	score ifNil: [ score := self absoluteScore ].
	
	^ score
]

{ #category : 'as yet unclassified' }
UmeFeedback >> unWrapCase: unwrapBlock [ 
	
	unwrapBlock ifNotNil: [ self case: (unwrapBlock value: case) ].
	
	^ self.
	
]

{ #category : 'accessing' }
UmeFeedback >> values [

	^ values
]

{ #category : 'accessing' }
UmeFeedback >> values: someValues [

	values := someValues
]
