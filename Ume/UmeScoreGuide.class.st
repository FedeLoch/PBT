Class {
	#name : 'UmeScoreGuide',
	#superclass : 'UmeFeedbackGuide',
	#category : 'Ume-Feedback',
	#package : 'Ume',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
UmeScoreGuide >> tableOfValue [

	^ evaluator customMetricsTable
]

{ #category : 'accessing' }
UmeScoreGuide >> values: case [

	^ { 'score' -> (evaluator category: case score) } asDictionary
]
