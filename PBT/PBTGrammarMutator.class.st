Class {
	#name : 'PBTGrammarMutator',
	#superclass : 'PBTStringMutator',
	#instVars : [
		'grammar',
		'characterTerminals',
		'maxInputSize'
	],
	#category : 'PBT-Mutators',
	#package : 'PBT',
	#tag : 'Mutators'
}

{ #category : 'instance creation' }
PBTGrammarMutator class >> from: aGrammar [

	^ self new gammar: aGrammar
]

{ #category : 'accessing' }
PBTGrammarMutator >> applyMutation: string [

	mutator options: (characterTerminals flatCollect: #values).
	^ mutator mutate: string
]

{ #category : 'as yet unclassified' }
PBTGrammarMutator >> gammar: aGrammar [
	
	grammar := aGrammar.
	characterTerminals := grammar terminals.
]

{ #category : 'initialization' }
PBTGrammarMutator >> initialize [ 
	
	super initialize.
	characterTerminals := {}.
	maxInputSize := SmallInteger maxVal.
	mutator := PBTAddElementMutator new
]

{ #category : 'testing' }
PBTGrammarMutator >> isReplace: string [

	^ string size >= maxInputSize
]

{ #category : 'accessing' }
PBTGrammarMutator >> maxInputSize: anInteger [

	maxInputSize := anInteger.
	mutator maxInputSize: anInteger
]
