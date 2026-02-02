Class {
	#name : 'PBTAddElementMutator',
	#superclass : 'PBTStringMutator',
	#instVars : [
		'maxInputSize',
		'options'
	],
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'accessing' }
PBTAddElementMutator >> applyMutation: string [

	| at from toInsert size |
	
	size := string size.
	toInsert := self randomStringCharacter.
	(string size < 2) ifTrue: [ ^ string, toInsert ].
	
	at := ( 2 to: size ) atRandom.
	from := (self isReplace: string) ifTrue: [ at + 1] ifFalse: [ at ].

	^ (string copyFrom: 1  to: at - 1), toInsert, (string copyFrom: from to: size)

]

{ #category : 'accessing' }
PBTAddElementMutator >> initialize [ 
	
	super initialize.
	maxInputSize := SmallInteger maxVal.
]

{ #category : 'accessing' }
PBTAddElementMutator >> isReplace: string [

	^ string size >= maxInputSize
]

{ #category : 'accessing' }
PBTAddElementMutator >> maxInputSize: size [

	maxInputSize := size
]

{ #category : 'accessing' }
PBTAddElementMutator >> options: someOptions [

	options := someOptions 
]

{ #category : 'accessing' }
PBTAddElementMutator >> randomStringCharacter [

	^ options atRandom
]
