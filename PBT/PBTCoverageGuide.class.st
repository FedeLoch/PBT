Class {
	#name : 'PBTCoverageGuide',
	#superclass : 'PBTFeedbackGuide',
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
PBTCoverageGuide >> tableOfValue [

	^ evaluator coverageTable
]

{ #category : 'accessing' }
PBTCoverageGuide >> values: case [

	^ case result profilingResult ifNil: [ Dictionary new ] ifNotNil: [
		case result profilingResult coverage collect: [ :value | evaluator category: value ]
	]
]
