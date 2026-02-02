Class {
	#name : 'UmeTreeGrammarMutatorJSONTest',
	#superclass : 'UmeStringMutatorTest',
	#instVars : [
		'mutator'
	],
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'running' }
UmeTreeGrammarMutatorJSONTest >> setUp [

	super setUp.
	mutator := UmeGrammarDerivationMutator from: JSONGrammar new.
]

{ #category : 'tests' }
UmeTreeGrammarMutatorJSONTest >> testMutatingAnEmptyString [

	self assert: (mutator mutate: '{}') equals:  '{}'
]

{ #category : 'tests' }
UmeTreeGrammarMutatorJSONTest >> testMutatingAnEmptyString02 [

	self assert: (mutator mutate: '{"n":true,"n":true,"x":6}') equals:  '{}'
]
