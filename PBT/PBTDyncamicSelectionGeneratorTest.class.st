Class {
	#name : 'PBTDyncamicSelectionGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#instVars : [
		'constTrueGen',
		'constFalseGen'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'running' }
PBTDyncamicSelectionGeneratorTest >> setUp [
	super setUp.
	constTrueGen := PBTConstantGenerator new value: true.
	constFalseGen := PBTConstantGenerator new value: false.
]

{ #category : 'tests' }
PBTDyncamicSelectionGeneratorTest >> testGenerateAnInstanceOfBooleanSelectingTheGeneratorByFeedback [

	| generator subGenerators feedback |
	
	subGenerators := { constTrueGen . constFalseGen }.
	feedback := nil.
	
	generator := PBTDyncamicSelectionGenerator new generators: subGenerators.

	self assert: (generator gen: nil by: false) class superclass equals: Boolean
	
]

{ #category : 'tests' }
PBTDyncamicSelectionGeneratorTest >> testGenerateAnInstanceOfBooleanWithTheSameProbability [

	| generator subGenerators |
	
	subGenerators := { constTrueGen . constFalseGen }.
	generator := PBTDyncamicSelectionGenerator new generators: subGenerators.

	self assert: (generator gen: nil by: false) class superclass equals: Boolean 
]
