Class {
	#name : 'UmeTreeGrammarMutatorRegexesTest',
	#superclass : 'UmeStringMutatorTest',
	#instVars : [
		'mutator'
	],
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'running' }
UmeTreeGrammarMutatorRegexesTest >> setUp [

	super setUp.
	self timeLimit: 5 hours.
	mutator := (UmeGrammarDerivationMutator from: GncRegexGrammar new) maxInputSize: 40.
	
]

{ #category : 'tests' }
UmeTreeGrammarMutatorRegexesTest >> testMutatingAnEmptyString [

	| str |
	str := 'ac?ab?ab?b?aa.?aaab?c?a(c)?ac?aaab?a?a'.
	
	10000 timesRepeat: [ | mutated |
		mutated := mutator mutate: str.
		[ UmeGrammarParser parse: mutated from: mutator grammar ] on: Error do: [ :e | 1 halt. ].
		str := mutated.
	].
]

{ #category : 'tests' }
UmeTreeGrammarMutatorRegexesTest >> testMutatingAnEmptyStringTestingMCTS [

	| generator grammar |
	
	generator := GrammarMCTSGenerator new
		             maxHeight: SmallInteger maxVal;
						 maxSize: 40;
		             totalGenerations: 1;
		             explorationConstant: 1.41.
		
	grammar := GncRegexGrammar new.

	100000 timesRepeat: [ | ast |
		ast := grammar start generateMCTSAst: generator level: 0.
		[ UmeGrammarParser parse: ast asStringInput from: grammar ] on: Error do: [ :e | 1 halt. ].
	].
]
