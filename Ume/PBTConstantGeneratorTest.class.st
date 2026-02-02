Class {
	#name : 'PBTConstantGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTConstantGeneratorTest >> testGenerateAlwaysTheSameValue [

	"it's not necessary to pass it a constraint argument"
	self assert: ((UmeConstantGenerator new value: { 42 }) gen: nil) equals: { 42 }
]
