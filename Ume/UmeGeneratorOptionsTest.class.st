Class {
	#name : 'UmeGeneratorOptionsTest',
	#superclass : 'UmeGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'tests' }
UmeGeneratorOptionsTest >> testGenerateAnInstanceOfBoolean [

	| generator options |
	
	options := { true . false }.
	generator := UmeOptionsGenerator new from: options.

	"it's not necessary to pass it a constraint argument"
	self assert: (options includes: (generator gen: nil)) equals: true
]

{ #category : 'tests' }
UmeGeneratorOptionsTest >> testGenerateAnInstanceOfSmallIntegerByRange [

	| generator |
	
	generator := UmeOptionsGenerator new from: (0 to: 100).

	"it's not necessary to pass it a constraint argument"
	self assert: ((0 to: 100) includes: (generator gen: nil)) equals: true
]

{ #category : 'tests' }
UmeGeneratorOptionsTest >> testGenerateAnInstanceOfStringByArray [

	| generator options |
	options := { 'h' . 'o' . 'l' . 'a' . 'k' . 'e' . 'a' . 'z' . 'e' }.
	generator := UmeOptionsGenerator new from: options.

	"it's not necessary to pass it a constraint argument"
	self assert: (options includes: (generator gen: nil)) equals: true
]
