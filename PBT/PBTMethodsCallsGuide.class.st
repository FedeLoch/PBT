Class {
	#name : 'PBTMethodsCallsGuide',
	#superclass : 'PBTFeedbackGuide',
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'accessing' }
PBTMethodsCallsGuide >> methodsCalledFrom: case [

	^ case result profilingResult ifNil: [ Dictionary new ] ifNotNil: [
		case result profilingResult methodsCalled collect: [ :value | evaluator category: value ]
	]
]

{ #category : 'as yet unclassified' }
PBTMethodsCallsGuide >> tableOfValue [

	^ evaluator methodsCalled
]

{ #category : 'accessing' }
PBTMethodsCallsGuide >> values: case [

	^ self methodsCalledFrom: case
]
