Class {
	#name : 'PBTGrammarTreeGeneratorTest',
	#superclass : 'TestCase',
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'tests' }
PBTGrammarTreeGeneratorTest >> testParseJsonObject01 [

	| input |
	
	input := '4'.
	
	self assert: (PBTGrammarTreeGenerator parse: input from: JSONGrammar new) equals: nil
]
