Class {
	#name : 'PBTGeneratorTest',
	#superclass : 'TestCase',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTGeneratorTest >> feedback: value [

	^ UmeFeedback from: nil value: value
]
