Class {
	#name : 'UmeObjectGrammarGeneratorTest',
	#superclass : 'UmeGeneratorTest',
	#instVars : [
		'generator'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'tests' }
UmeObjectGrammarGeneratorTest >> setUp [ 

	super setUp.
	generator := UmeObjectGrammarGenerator from: nil
]

{ #category : 'tests' }
UmeObjectGrammarGeneratorTest >> testGenerateARandomStringInputByGrammar [


	generator grammar: PzDateMDYYYYGrammar new.

	self assert: (generator gen: nil) class equals: Date
]

{ #category : 'tests' }
UmeObjectGrammarGeneratorTest >> testGenerateAlwaysTheSameValue [

	generator grammar: ConstantGrammar new.

	self assert: (generator gen: nil) equals: 42
]

{ #category : 'tests' }
UmeObjectGrammarGeneratorTest >> testGenerateAnInstanceOfBoolean [

	generator grammar: BooleanGrammar new.

	self assert: (generator gen: nil) class superclass equals: Boolean
]

{ #category : 'tests' }
UmeObjectGrammarGeneratorTest >> testGenerateAnInstanceOfPerson [

	generator grammar: PersonGrammar new.

	self assert: (generator gen: nil) class equals: Person
]

{ #category : 'tests' }
UmeObjectGrammarGeneratorTest >> testGenerateAnInstanceOfRectangle [

	generator grammar: RectangleGrammar new.

	self assert: (generator gen: nil) class equals: Rectangle
]

{ #category : 'tests' }
UmeObjectGrammarGeneratorTest >> testGenerateAnInstanceOfSmallIntegerByRange [

	generator grammar: DecimalGrammar new.

	self assert: ((0 to: 100) includes: (generator gen: nil)) equals: true
]
