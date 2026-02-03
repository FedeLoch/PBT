Class {
	#name : 'UmeFeedbackGuide',
	#superclass : 'Object',
	#instVars : [
		'evaluator'
	],
	#category : 'Ume-Feedback',
	#package : 'Ume',
	#tag : 'Feedback'
}

{ #category : 'accessing' }
UmeFeedbackGuide >> evaluator: anEvaluator [

	evaluator := anEvaluator
]

{ #category : 'initialization' }
UmeFeedbackGuide >> setBase: base [

	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
UmeFeedbackGuide >> tableOfValue [

	self subclassResponsibility 
]

{ #category : 'accessing' }
UmeFeedbackGuide >> values: case [

	self subclassResponsibility 
]
