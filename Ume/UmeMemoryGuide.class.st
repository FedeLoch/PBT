Class {
	#name : 'UmeMemoryGuide',
	#superclass : 'UmeFeedbackGuide',
	#category : 'Ume-Feedback',
	#package : 'Ume',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
UmeMemoryGuide >> tableOfValue [

	^ evaluator memoryTable
]

{ #category : 'accessing' }
UmeMemoryGuide >> values: case [

	^ case result profilingResult ifNil: [ Dictionary new ] ifNotNil: [
		case result profilingResult memory collect: [ :value | evaluator category: value ]
	]
]
