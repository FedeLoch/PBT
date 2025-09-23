Class {
	#name : 'PBTExecutionTimeGuide',
	#superclass : 'PBTFeedbackGuide',
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
PBTExecutionTimeGuide >> tableOfValue [

	^ evaluator performanceTable
]

{ #category : 'accessing' }
PBTExecutionTimeGuide >> values: case [

	1 halt.
]
