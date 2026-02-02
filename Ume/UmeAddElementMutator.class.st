Class {
	#name : 'UmeAddElementMutator',
	#superclass : 'UmeStringMutator',
	#instVars : [
		'maxInputSize',
		'options'
	],
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'accessing' }
UmeAddElementMutator >> applyMutation: string [

	| at from toInsert size |
	
	size := string size.
	toInsert := self randomStringCharacter.
	(string size < 2) ifTrue: [ ^ string, toInsert ].
	
	at := ( 2 to: size ) atRandom.
	from := (self isReplace: string) ifTrue: [ at + 1] ifFalse: [ at ].

	^ (string copyFrom: 1  to: at - 1), toInsert, (string copyFrom: from to: size)

]

{ #category : 'accessing' }
UmeAddElementMutator >> initialize [ 
	
	super initialize.
	maxInputSize := SmallInteger maxVal.
]

{ #category : 'accessing' }
UmeAddElementMutator >> isReplace: string [

	^ string size >= maxInputSize
]

{ #category : 'accessing' }
UmeAddElementMutator >> maxInputSize: size [

	maxInputSize := size
]

{ #category : 'accessing' }
UmeAddElementMutator >> options: someOptions [

	options := someOptions 
]

{ #category : 'accessing' }
UmeAddElementMutator >> randomStringCharacter [

	^ options atRandom
]
