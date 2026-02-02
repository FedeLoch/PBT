Class {
	#name : 'PBTDyncamicSelectionGeneratorTest',
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
PBTDyncamicSelectionGeneratorTest >> setUp [
	super setUp.
	constTrueGen := UmeConstantGenerator new value: true.
	constFalseGen := UmeConstantGenerator new value: false.
]

{ #category : 'tests' }
PBTDyncamicSelectionGeneratorTest >> testGenerateAnInstanceOfBooleanSelectingTheGeneratorByFeedback [

	| generator subGenerators feedback |
	
	subGenerators := { constTrueGen . constFalseGen }.
	feedback := nil.
	
	generator := PBTDyncamicSelectionGenerator new generators: subGenerators.

	self assert: (generator gen: nil) class superclass equals: Boolean
	
]

{ #category : 'tests' }
PBTDyncamicSelectionGeneratorTest >> testGenerateAnInstanceOfBooleanWithTheSameProbability [

	| generator subGenerators |
	
	subGenerators := { constTrueGen . constFalseGen }.
	generator := PBTDyncamicSelectionGenerator new generators: subGenerators.

	self assert: (generator gen: nil) class superclass equals: Boolean 
]
