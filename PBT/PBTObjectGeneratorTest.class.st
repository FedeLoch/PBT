Class {
	#name : 'PBTObjectGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Input Generation',
	#package : 'PBT',
	#tag : 'Input Generation'
}

{ #category : 'tests' }
PBTObjectGeneratorTest >> testGenerateAnInstanceOfACollectionOfIntegers [

	| generator range |
	
	range := (0 to: 100).
	generator := PBTOptionsGenerator new from: range.

	"it's not necessary to pass it a constraint argument"
	self assert: (range includes: (generator gen: nil)) equals: true
]
