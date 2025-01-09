Class {
	#name : 'PBTConstantGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTConstantGeneratorTest >> testGenerateAlwaysTheSameValue [

	"it's not necessary to pass it a constraint argument"
	self assert: ((PBTConstantGenerator new value: { 42 }) gen: nil) equals: { 42 }
]
