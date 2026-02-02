Class {
	#name : 'PBTGrammarSdGenGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTGrammarSdGenGeneratorTest >> testGenerateARandomStringFromAGivenADateGrammar [

	| generator |
	
	generator := PBTGrammarSdGenGenerator from: PzDateMDYYYYGrammar new ofDepth: 10.
	
	self assert: (Date readFrom: (generator gen: nil) pattern: 'm-d-y') class equals: Date
]

{ #category : 'tests' }
PBTGrammarSdGenGeneratorTest >> testGenerateARandomStringFromAGivenAJSONGrammar [

	| generator generated |
	
	generator := PBTGrammarSdGenGenerator from: JSONGrammar new ofDepth: 10.
	generated := generator gen: nil.
	self assert: ({ Array . SmallInteger . True . False . Dictionary . UndefinedObject } includes: (NeoJSONReader fromString: generated) class) equals: true 
]

{ #category : 'tests' }
PBTGrammarSdGenGeneratorTest >> testGenerateARandomStringFromAGivenARegexGrammar [

	| generator |
	
	generator := PBTGrammarSdGenGenerator from: GncRegexGrammar new ofDepth: 10.
	
	self assert: (generator gen: nil) asRegex class equals: RxMatcher
]
