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
	mutator := (PBTTreeGrammarMutator from: GncRegexGrammar new) maxInputSize: 40.
	
]

{ #category : 'tests' }
PBTTreeGrammarMutatorRegexesTest >> testMutatingAnEmptyString [

	| str |
	str := 'ac?ab?ab?b?aa.?aaab?c?a(c)?ac?aaab?a?a'.
	
	1000 timesRepeat: [ | mutated |
		mutated := mutator mutate: str.
		[ PBTGrammarParser parse: mutated from: mutator grammar ] on: Error do: [ :e | 1 halt. ].
		str := mutated.
	].
1 halt.
]

{ #category : 'tests' }
PBTTreeGrammarMutatorRegexesTest >> testsubNodesFromOfAvalidNode [

	| str ast node parentSize parentSize newChildren |
	
	"TODO: DELETE ME"
	str := 'ac?ab?ab?b?aa.?aaab?c?a(c)?ac?aaab?a?a'.
	ast := PBTGrammarParser parse: str from: mutator grammar.
	node := ast aLeaf parent.
	parentSize := ast generate size - (node generate size).
	newChildren := mutator subNodesFrom: node grammarRule parentSize: parentSize level: (ast treeHeight - node treeHeight).
	1 halt.
]
