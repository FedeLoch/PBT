Class {
	#name : 'UmeGenericGeneratorTest',
	#superclass : 'UmeGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
UmeGenericGeneratorTest >> testGenerateAConstantString [

	| generator |

	generator := UmeGenerator do:[ :props :feedback | 'hello' ].

	self assert: (generator gen: nil) equals: 'hello'
]
