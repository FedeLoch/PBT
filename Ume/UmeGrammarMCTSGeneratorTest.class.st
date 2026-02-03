Class {
	#name : 'UmeGrammarMCTSGeneratorTest',
	#superclass : 'UmeGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'tests' }
UmeGrammarMCTSGeneratorTest >> testGenerateARandomDemaProgramFromADemaGrammar [

	| generator generated |
	generator := UmeGrammarMCTSGenerator from: DemaGrammar new.
	generated := generator gen: nil.
]

{ #category : 'tests' }
UmeGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenADateGrammar [

	| generator |
	
	generator := UmeGrammarMCTSGenerator from: PzDateMDYYYYGrammar new.

	self assert: (Date readFrom: (generator gen: nil) pattern: 'm-d-y') class equals: Date
]

{ #category : 'tests' }
UmeGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenADateGrammarGuidedByFeedback [

	| generator |
	
	generator := UmeGrammarMCTSGenerator from: PzDateMDYYYYGrammar new.
	
	generator gen: nil.
	generator feed: (self feedback: false).

	self assert: (Date readFrom: (generator gen: nil) pattern: 'm-d-y') class equals: Date
]

{ #category : 'tests' }
UmeGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenARegexGrammar [

	| generator |
	
	generator := UmeGrammarMCTSGenerator from: GncRegexGrammar new.

	self assert: (generator gen: nil) asRegex class equals: RxMatcher 
]

{ #category : 'tests' }
UmeGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenARegexGrammarGuidedByFeedback [

	| generator |
	
	generator := UmeGrammarMCTSGenerator from: GncRegexGrammar new.
	
	generator gen: nil.
	generator feed: (self feedback: false).

	self assert: (generator gen: nil) asRegex class equals: RxMatcher
]

{ #category : 'tests' }
UmeGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenAStonGrammar [

	| generator generated result |
	generator := UmeGrammarMCTSGenerator from: GncStonGrammar new.
	generated := generator gen: nil.

	result := STON reader on: generated readStream; next.

	self assert: (result class name beginsWith: 'GncFuzzyClass')
]
