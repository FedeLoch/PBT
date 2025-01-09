Class {
	#name : 'PBTGeneratorOptionsTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Input Generation',
	#package : 'PBT',
	#tag : 'Input Generation'
}

{ #category : 'tests' }
PBTGeneratorOptionsTest >> testGenerateAnInstanceOfSmallIntegerByRange [

	| generator range |
	
	range := (0 to: 100).
	generator := PBTOptionsGenerator new from: range.

	"it's not necessary to pass it a constraint argument"
	self assert: (range includes: (generator gen: nil)) equals: true
]

{ #category : 'tests' }
PBTGeneratorOptionsTest >> testGenerateAnInstanceOfStringByArray [

	| generator options |
	options := { 'h' . 'o' . 'l' . 'a' . 'k' . 'e' . 'a' . 'z' . 'e' }.
	generator := PBTOptionsGenerator new from: options.

	"it's not necessary to pass it a constraint argument"
	self assert: (options includes: (generator gen: nil)) equals: true
]
