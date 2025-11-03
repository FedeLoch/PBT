Class {
	#name : 'PBTTreeGrammarMutatorJSONTest',
	#superclass : 'PBTStringMutatorTest',
	#instVars : [
		'mutator'
	],
	#category : 'PBT-Mutators',
	#package : 'PBT',
	#tag : 'Mutators'
}

{ #category : 'running' }
PBTTreeGrammarMutatorJSONTest >> setUp [

	super setUp.
	mutator := PBTTreeGrammarMutator from: JSONGrammar new.
]

{ #category : 'tests' }
PBTTreeGrammarMutatorJSONTest >> testMutatingAnEmptyString [

	self assert: (mutator mutate: '{}') equals:  '{}'
]

{ #category : 'tests' }
PBTTreeGrammarMutatorJSONTest >> testMutatingAnEmptyString02 [

	self assert: (mutator mutate: '{"n":true,"n":true,"x":6}') equals:  '{}'
]
