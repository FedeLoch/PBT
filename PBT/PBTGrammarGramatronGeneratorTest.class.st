Class {
	#name : 'PBTGrammarGramatronGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTGrammarGramatronGeneratorTest >> testGenerateARandomStringFromAGivenARegexGrammar [

	| generator regex |
	
	generator := PBTGrammarGramatronGenerator from: GnfRegexGrammar new ofDepth: 10.
	
	regex := generator gen: nil by: (self feedback: false).
	
	self assert: regex asRegex class equals: RxMatcher.
	self assert: (regex ~= '') equals: true.
]
