Class {
	#name : 'PBTAddByteMutator',
	#superclass : 'PBTStringMutator',
	#instVars : [
		'maxInputSize'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTAddByteMutator >> applyMutation: string [

	| at from toInsert size |
	
	size := string size.
	at := ( 2 to: size ) atRandom.
	toInsert := self randomStringCharacter.
	from := (self isReplace: string) ifTrue: [ at + 1] ifFalse: [ at ].

	^ (string copyFrom: 1  to: at - 1), toInsert, (string copyFrom: from to: size)

]

{ #category : 'accessing' }
PBTAddByteMutator >> initialize [ 
	
	super initialize.
	maxInputSize := SmallInteger maxVal.
]

{ #category : 'accessing' }
PBTAddByteMutator >> isReplace: string [

	^ string size >= maxInputSize
]

{ #category : 'accessing' }
PBTAddByteMutator >> maxInputSize: size [

	maxInputSize := size
]

{ #category : 'accessing' }
PBTAddByteMutator >> randomStringCharacter [

	^ ((33 to: 126) collect: [:v | (Character value: v) asString ]) atRandom
]
