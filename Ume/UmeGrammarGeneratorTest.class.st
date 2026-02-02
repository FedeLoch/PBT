Class {
	#name : 'UmeGrammarGeneratorTest',
	#superclass : 'UmeGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
UmeGrammarGeneratorTest >> testGenerateARandomStringInputByGrammar [

	| generator grammar |

	grammar := PzDateMDYYYYGrammar new.
	generator := UmeGrammarGenerator new grammar: grammar.

	self assert: (Date readFrom: (generator gen: nil) pattern: 'm-d-y') class equals: Date
]
