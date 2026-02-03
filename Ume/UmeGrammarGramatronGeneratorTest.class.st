Class {
	#name : 'UmeGrammarGramatronGeneratorTest',
	#superclass : 'UmeGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'tests' }
UmeGrammarGramatronGeneratorTest >> testGenerateARandomStringFromAGivenARegexGrammar [

	| generator regex |
	
	generator := UmeGrammarGramatronGenerator from: GnfRegexGrammar new ofDepth: 10.
	
	regex := generator gen: nil.
	
	self assert: regex asRegex class equals: RxMatcher.
	self assert: (regex ~= '') equals: true.
]
