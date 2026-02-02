Class {
	#name : 'PBTGrammarLiteralsMutator',
	#superclass : 'PBTStringMutator',
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
PBTGrammarLiteralsMutator class >> from: aGrammar [

	^ self new gammar: aGrammar
]

{ #category : 'accessing' }
PBTGrammarLiteralsMutator >> applyMutation: string [

	mutator options: (characterTerminals flatCollect: #values).
	^ mutator mutate: string
]

{ #category : 'as yet unclassified' }
PBTGrammarLiteralsMutator >> gammar: aGrammar [
	
	grammar := aGrammar.
	characterTerminals := grammar terminals.
]

{ #category : 'initialization' }
PBTGrammarLiteralsMutator >> initialize [ 
	
	super initialize.
	characterTerminals := {}.
	maxInputSize := SmallInteger maxVal.
	mutator := PBTAddElementMutator new
]

{ #category : 'testing' }
PBTGrammarLiteralsMutator >> isReplace: string [

	^ string size >= maxInputSize
]

{ #category : 'accessing' }
PBTGrammarLiteralsMutator >> maxInputSize: anInteger [

	maxInputSize := anInteger.
	mutator maxInputSize: anInteger
]
