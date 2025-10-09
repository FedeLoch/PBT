Class {
	#name : 'PBTGrammarMutator',
	#superclass : 'PBTStringMutator',
	#instVars : [
		'grammar',
		'characterTerminals',
		'maxInputSize'
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
PBTGrammarMutator >> applyMutation: string [

	"TODO: Reuse this code."
	| size at toInsert from |
	size := string size.
	at := ( 2 to: size ) atRandom.
	toInsert := self randomLiteral.
	from := (self isReplace: string) ifTrue: [ at + 1] ifFalse: [ at ].

	^ (string copyFrom: 1  to: at - 1), toInsert, (string copyFrom: from to: size)
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
]

{ #category : 'testing' }
PBTGrammarMutator >> isReplace: string [

	^ string size >= maxInputSize
]

{ #category : 'accessing' }
PBTGrammarMutator >> maxInputSize: anInteger [

	maxInputSize := anInteger
]

{ #category : 'as yet unclassified' }
PBTGrammarMutator >> randomLiteral [

	^ characterTerminals atRandom literal
]
