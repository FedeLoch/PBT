Class {
	#name : 'PBTGeneratorTest',
	#superclass : 'TestCase',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTGeneratorTest >> feedback: value [

	^ PBTFeedback from: nil value: value
]
