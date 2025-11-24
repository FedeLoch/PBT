Class {
	#name : 'PBTBytecodesGuide',
	#superclass : 'PBTFeedbackGuide',
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
PBTBytecodesGuide >> tableOfValue [

	^ evaluator bytecodesTable
]

{ #category : 'accessing' }
PBTBytecodesGuide >> values: case [

	^ case result profilingResult ifNil: [ Dictionary new ] ifNotNil: [
		case result profilingResult bytecodes collect: [ :value | evaluator category: value ]
	]
]
