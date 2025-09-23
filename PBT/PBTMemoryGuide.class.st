Class {
	#name : 'PBTMemoryGuide',
	#superclass : 'PBTFeedbackGuide',
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
PBTMemoryGuide >> tableOfValue [

	^ evaluator memoryTable
]

{ #category : 'accessing' }
PBTMemoryGuide >> values: case [

	1 halt.
]
