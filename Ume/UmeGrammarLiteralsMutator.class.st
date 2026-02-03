Class {
	#name : 'UmeGrammarLiteralsMutator',
	#superclass : 'UmeStringMutator',
	#instVars : [
		'grammar',
		'characterTerminals',
		'maxInputSize'
	],
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'instance creation' }
UmeGrammarLiteralsMutator class >> from: aGrammar [

	^ self new gammar: aGrammar
]

{ #category : 'accessing' }
UmeGrammarLiteralsMutator >> applyMutation: string [

	mutator options: (characterTerminals flatCollect: #values).
	^ mutator mutate: string
]

{ #category : 'as yet unclassified' }
UmeGrammarLiteralsMutator >> gammar: aGrammar [
	
	grammar := aGrammar.
	characterTerminals := grammar terminals.
]

{ #category : 'initialization' }
UmeGrammarLiteralsMutator >> initialize [ 
	
	super initialize.
	characterTerminals := {}.
	maxInputSize := SmallInteger maxVal.
	mutator := UmeAddElementMutator new
]

{ #category : 'testing' }
UmeGrammarLiteralsMutator >> isReplace: string [

	^ string size >= maxInputSize
]

{ #category : 'accessing' }
UmeGrammarLiteralsMutator >> maxInputSize: anInteger [

	maxInputSize := anInteger.
	mutator maxInputSize: anInteger
]
