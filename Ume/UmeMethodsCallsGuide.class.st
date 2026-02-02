Class {
	#name : 'UmeMethodsCallsGuide',
	#superclass : 'UmeFeedbackGuide',
	#category : 'Ume-Feedback',
	#package : 'Ume',
	#tag : 'Feedback'
}

{ #category : 'accessing' }
UmeMethodsCallsGuide >> setBase: base [

	evaluator methodsCalled: base

]

{ #category : 'as yet unclassified' }
UmeMethodsCallsGuide >> tableOfValue [

	^ evaluator methodsCalled
]

{ #category : 'accessing' }
UmeMethodsCallsGuide >> values: case [

	^ case result profilingResult ifNil: [ Dictionary new ] ifNotNil: [
		case result profilingResult methodsCalled collect: [ :value | evaluator category: value ]
	]
]
