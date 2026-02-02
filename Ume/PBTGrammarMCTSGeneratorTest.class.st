Class {
	#name : 'PBTGrammarMCTSGeneratorTest',
	#superclass : 'UmeGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTGrammarMCTSGeneratorTest >> testGenerateARandomDemaProgramFromADemaGrammar [

	| generator generated |
	generator := PBTGrammarMCTSGenerator from: DemaGrammar new.
	generated := generator gen: nil.
]

{ #category : 'tests' }
PBTGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenADateGrammar [

	| generator |
	
	generator := PBTGrammarMCTSGenerator from: PzDateMDYYYYGrammar new.

	self assert: (Date readFrom: (generator gen: nil) pattern: 'm-d-y') class equals: Date
]

{ #category : 'tests' }
PBTGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenADateGrammarGuidedByFeedback [

	| generator |
	
	generator := PBTGrammarMCTSGenerator from: PzDateMDYYYYGrammar new.
	
	generator gen: nil.
	generator feed: (self feedback: false).

	self assert: (Date readFrom: (generator gen: nil) pattern: 'm-d-y') class equals: Date
]

{ #category : 'tests' }
PBTGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenARegexGrammar [

	| generator |
	
	generator := PBTGrammarMCTSGenerator from: GncRegexGrammar new.

	self assert: (generator gen: nil) asRegex class equals: RxMatcher 
]

{ #category : 'tests' }
PBTGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenARegexGrammarGuidedByFeedback [

	| generator |
	
	generator := PBTGrammarMCTSGenerator from: GncRegexGrammar new.
	
	generator gen: nil.
	generator feed: (self feedback: false).

	self assert: (generator gen: nil) asRegex class equals: RxMatcher
]

{ #category : 'tests' }
PBTGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenAStonGrammar [

	| generator generated result |
	generator := PBTGrammarMCTSGenerator from: GncStonGrammar new.
	generated := generator gen: nil.

	result := STON reader on: generated readStream; next.

	self assert: (result class name beginsWith: 'GncFuzzyClass')
]
