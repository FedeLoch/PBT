Class {
	#name : 'PBTGeneratorTest',
	#superclass : 'TestCase',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTGeneratorTest >> feedback: value [

	^ PBTFeedback having: nil current: nil with: nil isBetter: value
]
