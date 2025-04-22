Class {
	#name : 'PBTGenericGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTGenericGeneratorTest >> testGenerateAConstantString [

	| generator |

	generator := PBTGenerator do:[ :props :feedback | 'hello' ].

	self assert: (generator gen: nil by: true) equals: 'hello'
]
