Class {
	#name : 'PBTGrammarGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTGrammarGeneratorTest >> testGenerateARandomStringInputByGrammar [

	| generator grammar |

	grammar := PzDateMDYYYYGrammar new.
	generator := PBTGrammarGenerator new grammar: grammar.

	self assert: (Date readFrom: (generator gen: nil) pattern: 'm-d-y') class equals: Date
]
