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

	^ case result profilingResult ifNil: [ Dictionary new ] ifNotNil: [
		case result profilingResult memory collect: [ :value | evaluator category: value ]
	]
]
