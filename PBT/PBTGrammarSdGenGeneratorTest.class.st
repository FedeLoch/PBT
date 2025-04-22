Class {
	#name : 'PBTGrammarSdGenGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTGrammarSdGenGeneratorTest >> testGenerateARandomStringFromAGivenADateGrammar [

	| generator |
	
	generator := PBTGrammarSdGenGenerator from: PzDateMDYYYYGrammar new ofDepth: 10.
	
	self assert: (Date readFrom: (generator gen: nil by: (self feedback: nil)) pattern: 'm-d-y') class equals: Date
]

{ #category : 'tests' }
PBTGrammarSdGenGeneratorTest >> testGenerateARandomStringFromAGivenARegexGrammar [

	| generator |
	
	generator := PBTGrammarSdGenGenerator from: GncRegexGrammar new ofDepth: 10.
	
	self assert: (generator gen: nil by: (self feedback: false)) asRegex class equals: RxMatcher
]
