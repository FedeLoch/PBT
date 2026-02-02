Class {
	#name : 'PBTTreeGrammarMutatorJSONTest',
	#superclass : 'PBTStringMutatorTest',
	#instVars : [
		'mutator'
	],
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'running' }
PBTTreeGrammarMutatorJSONTest >> setUp [

	super setUp.
	mutator := PBTGrammarDerivationMutator from: JSONGrammar new.
]

{ #category : 'tests' }
PBTTreeGrammarMutatorJSONTest >> testMutatingAnEmptyString [

	self assert: (mutator mutate: '{}') equals:  '{}'
]

{ #category : 'tests' }
PBTTreeGrammarMutatorJSONTest >> testMutatingAnEmptyString02 [

	self assert: (mutator mutate: '{"n":true,"n":true,"x":6}') equals:  '{}'
]
