Class {
	#name : 'PBTTreeGrammarMutatorRegexesTest',
	#superclass : 'PBTStringMutatorTest',
	#instVars : [
		'mutator'
	],
	#category : 'PBT-Mutators',
	#package : 'PBT',
	#tag : 'Mutators'
}

{ #category : 'running' }
PBTTreeGrammarMutatorRegexesTest >> setUp [

	super setUp.
	self timeLimit: 5 hours.
	mutator := (PBTTreeGrammarMutator from: GncRegexGrammar new) maxInputSize: 40.
	
]

{ #category : 'tests' }
PBTTreeGrammarMutatorRegexesTest >> testMutatingAnEmptyString [

	| str |
	str := 'ac?ab?ab?b?aa.?aaab?c?a(c)?ac?aaab?a?a'.
	
	10000 timesRepeat: [ | mutated |
		mutated := mutator mutate: str.
		[ PBTGrammarParser parse: mutated from: mutator grammar ] on: Error do: [ :e | 1 halt. ].
		str := mutated.
	].
]

{ #category : 'tests' }
PBTTreeGrammarMutatorRegexesTest >> testMutatingAnEmptyStringTestingMCTS [

	| generator grammar |
	
	generator := GrammarMCTSGenerator new
		             maxHeight: SmallInteger maxVal;
						 maxSize: 40;
		             totalGenerations: 1;
		             explorationConstant: 1.41.
		
	grammar := GncRegexGrammar new.

	100000 timesRepeat: [ | ast |
		ast := grammar start generateMCTSAst: generator level: 0.
		[ PBTGrammarParser parse: ast asStringInput from: grammar ] on: Error do: [ :e | 1 halt. ].
	].
]
