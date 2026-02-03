Class {
	#name : 'UmeBytecodesGuide',
	#superclass : 'UmeFeedbackGuide',
	#category : 'Ume-Feedback',
	#package : 'Ume',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
UmeBytecodesGuide >> tableOfValue [

	^ evaluator bytecodesTable
]

{ #category : 'accessing' }
UmeBytecodesGuide >> values: case [

	^ case result profilingResult ifNil: [ Dictionary new ] ifNotNil: [
		case result profilingResult bytecodes collect: [ :value | evaluator category: value ]
	]
]
