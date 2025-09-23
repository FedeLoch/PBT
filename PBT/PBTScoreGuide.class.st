Class {
	#name : 'PBTScoreGuide',
	#superclass : 'PBTFeedbackGuide',
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
PBTScoreGuide >> tableOfValue [

	^ evaluator customMetricsTable
]

{ #category : 'accessing' }
PBTScoreGuide >> values: case [

	1 halt.
]
