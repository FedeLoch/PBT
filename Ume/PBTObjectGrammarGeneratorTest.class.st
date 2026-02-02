Class {
	#name : 'PBTObjectGrammarGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#instVars : [
		'generator'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTObjectGrammarGeneratorTest >> setUp [ 

	super setUp.
	generator := PBTObjectGrammarGenerator from: nil
]

{ #category : 'tests' }
PBTObjectGrammarGeneratorTest >> testGenerateARandomStringInputByGrammar [


	generator grammar: PzDateMDYYYYGrammar new.

	self assert: (generator gen: nil) class equals: Date
]

{ #category : 'tests' }
PBTObjectGrammarGeneratorTest >> testGenerateAlwaysTheSameValue [

	generator grammar: ConstantGrammar new.

	self assert: (generator gen: nil) equals: 42
]

{ #category : 'tests' }
PBTObjectGrammarGeneratorTest >> testGenerateAnInstanceOfBoolean [

	generator grammar: BooleanGrammar new.

	self assert: (generator gen: nil) class superclass equals: Boolean
]

{ #category : 'tests' }
PBTObjectGrammarGeneratorTest >> testGenerateAnInstanceOfPerson [

	generator grammar: PersonGrammar new.

	self assert: (generator gen: nil) class equals: Person
]

{ #category : 'tests' }
PBTObjectGrammarGeneratorTest >> testGenerateAnInstanceOfRectangle [

	generator grammar: RectangleGrammar new.

	self assert: (generator gen: nil) class equals: Rectangle
]

{ #category : 'tests' }
PBTObjectGrammarGeneratorTest >> testGenerateAnInstanceOfSmallIntegerByRange [

	generator grammar: DecimalGrammar new.

	self assert: ((0 to: 100) includes: (generator gen: nil)) equals: true
]
