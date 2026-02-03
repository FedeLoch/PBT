Class {
	#name : 'UmeConstantGeneratorTest',
	#superclass : 'UmeGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'tests' }
UmeConstantGeneratorTest >> testGenerateAlwaysTheSameValue [

	"it's not necessary to pass it a constraint argument"
	self assert: ((UmeConstantGenerator new value: { 42 }) gen: nil) equals: { 42 }
]
