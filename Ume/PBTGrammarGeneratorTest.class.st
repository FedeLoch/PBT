Class {
	#name : 'PBTGrammarGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTGrammarGeneratorTest >> testGenerateARandomStringInputByGrammar [

	| generator grammar |

	grammar := PzDateMDYYYYGrammar new.
	generator := PBTGrammarGenerator new grammar: grammar.

	self assert: (Date readFrom: (generator gen: nil) pattern: 'm-d-y') class equals: Date
]
