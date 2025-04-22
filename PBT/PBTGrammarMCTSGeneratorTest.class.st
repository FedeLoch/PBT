Class {
	#name : 'PBTGrammarMCTSGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenADateGrammar [

	| generator |
	
	generator := PBTGrammarMCTSGenerator from: PzDateMDYYYYGrammar new.

	self assert: (Date readFrom: (generator gen: nil by: (self feedback: nil)) pattern: 'm-d-y') class equals: Date
]

{ #category : 'tests' }
PBTGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenADateGrammarGuidedByFeedback [

	| generator |
	
	generator := PBTGrammarMCTSGenerator from: PzDateMDYYYYGrammar new.
	
	generator gen: nil by: (self feedback: true).

	self assert: (Date readFrom: (generator gen: nil by: (self feedback: false)) pattern: 'm-d-y') class equals: Date
]

{ #category : 'tests' }
PBTGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenARegexGrammar [

	| generator |
	
	generator := PBTGrammarMCTSGenerator from: GncRegexGrammar new.

	self assert: (generator gen: nil by: (self feedback: nil)) asRegex class equals: RxMatcher 
]

{ #category : 'tests' }
PBTGrammarMCTSGeneratorTest >> testGenerateARandomStringFromAGivenARegexGrammarGuidedByFeedback [

	| generator |
	
	generator := PBTGrammarMCTSGenerator from: GncRegexGrammar new.
	
	generator gen: nil by: (self feedback: true).

	self assert: (generator gen: nil by: (self feedback: false)) asRegex class equals: RxMatcher
]
