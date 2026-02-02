Class {
	#name : 'UmeGeneratorTest',
	#superclass : 'TestCase',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'accessing' }
UmeGeneratorTest >> feedback: value [

	^ UmeFeedback from: nil value: value
]
