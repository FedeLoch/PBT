Class {
	#name : 'PBTFeedback',
	#superclass : 'Object',
	#instVars : [
		'case',
		'feedback',
		'improvement',
		'values',
		'score'
	],
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
PBTFeedback class >> from: case improvement: improvement values: values [

	^ self new case: case; feedback: improvement > 0; improvement: improvement; values: values
]

{ #category : 'accessing' }
PBTFeedback >> absoluteScore [

	^ self relevantValues inject: 0 into: [ :acc :key | key value + acc ]
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

{ #category : 'accessing' }
PBTFeedback >> relevantValues [

	^ values select: [ :k | k value ~= 0 ]
]

{ #category : 'accessing' }
PBTFeedback >> score [

	score ifNil: [ score := self absoluteScore ].
	
	^ score
]

{ #category : 'as yet unclassified' }
PBTFeedback >> unWrapCase: unwrapBlock [ 
	
	unwrapBlock ifNotNil: [ self case: (unwrapBlock value: case) ].
	
	^ self.
	
]

{ #category : 'accessing' }
PBTFeedback >> values [

	^ values
]

{ #category : 'accessing' }
PBTFeedback >> values: someValues [

	values := someValues
]
