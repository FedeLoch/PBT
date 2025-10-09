Class {
	#name : 'PBTGrammarMutator',
	#superclass : 'PBTStringMutator',
	#instVars : [
		'grammar'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
PBTGrammarMutator class >> from: aGrammar [

	^ self new gammar: aGrammar
]

{ #category : 'accessing' }
PBTGrammarMutator >> applyMutation: input [

	^ grammar mutateValidInput: input

]

{ #category : 'as yet unclassified' }
PBTGrammarMutator >> gammar: aGrammar [
	
	grammar := aGrammar 
]
