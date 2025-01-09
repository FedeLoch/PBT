Class {
	#name : 'PBTGeneratorOptionsTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTGeneratorOptionsTest >> testGenerateAnInstanceOfSmallIntegerByRange [

	| generator |
	
	generator := PBTOptionsGenerator new from: (0 to: 100).

	"it's not necessary to pass it a constraint argument"
	self assert: ((0 to: 100) includes: (generator gen: nil)) equals: true
]

{ #category : 'tests' }
PBTGeneratorOptionsTest >> testGenerateAnInstanceOfStringByArray [

	| generator options |
	options := { 'h' . 'o' . 'l' . 'a' . 'k' . 'e' . 'a' . 'z' . 'e' }.
	generator := PBTOptionsGenerator new from: options.

	"it's not necessary to pass it a constraint argument"
	self assert: (options includes: (generator gen: nil)) equals: true
]
