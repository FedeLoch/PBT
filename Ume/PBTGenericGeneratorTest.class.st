Class {
	#name : 'PBTGenericGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTGenericGeneratorTest >> testGenerateAConstantString [

	| generator |

	generator := UmeGenerator do:[ :props :feedback | 'hello' ].

	self assert: (generator gen: nil) equals: 'hello'
]
