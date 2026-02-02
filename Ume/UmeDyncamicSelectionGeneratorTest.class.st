Class {
	#name : 'UmeDyncamicSelectionGeneratorTest',
	#superclass : 'UmeGeneratorTest',
	#instVars : [
		'constTrueGen',
		'constFalseGen'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'running' }
UmeDyncamicSelectionGeneratorTest >> setUp [
	super setUp.
	constTrueGen := UmeConstantGenerator new value: true.
	constFalseGen := UmeConstantGenerator new value: false.
]

{ #category : 'tests' }
UmeDyncamicSelectionGeneratorTest >> testGenerateAnInstanceOfBooleanSelectingTheGeneratorByFeedback [

	| generator subGenerators feedback |
	
	subGenerators := { constTrueGen . constFalseGen }.
	feedback := nil.
	
	generator := UmeDyncamicSelectionGenerator new generators: subGenerators.

	self assert: (generator gen: nil) class superclass equals: Boolean
	
]

{ #category : 'tests' }
UmeDyncamicSelectionGeneratorTest >> testGenerateAnInstanceOfBooleanWithTheSameProbability [

	| generator subGenerators |
	
	subGenerators := { constTrueGen . constFalseGen }.
	generator := UmeDyncamicSelectionGenerator new generators: subGenerators.

	self assert: (generator gen: nil) class superclass equals: Boolean 
]
