Class {
	#name : 'PBTFeedbackGuide',
	#superclass : 'Object',
	#instVars : [
		'evaluator'
	],
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'accessing' }
PBTFeedbackGuide >> evaluator: anEvaluator [

	evaluator := anEvaluator
]

{ #category : 'initialization' }
PBTFeedbackGuide >> setBase: base [

	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
PBTFeedbackGuide >> tableOfValue [

	self subclassResponsibility 
]

{ #category : 'accessing' }
PBTFeedbackGuide >> values: case [

	self subclassResponsibility 
]
