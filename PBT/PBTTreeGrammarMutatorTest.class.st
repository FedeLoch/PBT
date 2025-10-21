Class {
	#name : 'PBTTreeGrammarMutatorTest',
	#superclass : 'PBTStringMutatorTest',
	#instVars : [
		'mutator'
	],
	#category : 'PBT-Mutators',
	#package : 'PBT',
	#tag : 'Mutators'
}

{ #category : 'running' }
PBTTreeGrammarMutatorTest >> setUp [

	super setUp.
	mutator := PBTTreeGrammarMutator from: JSONGrammar new.
]

{ #category : 'tests' }
PBTTreeGrammarMutatorTest >> testMutatingAnEmptyString [

	self assert: (mutator mutate: '{}') equals:  '{}'
]

{ #category : 'tests' }
PBTTreeGrammarMutatorTest >> testMutatingAnEmptyString02 [

	self assert: (mutator mutate: '{"n":true,"n":true,"x":6}') equals:  '{}'
]
