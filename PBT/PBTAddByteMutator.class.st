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

	| at from toInsert |
	
	at := string size atRandom.
	toInsert := (1 to: 126) atRandom asCharacter asString.
	from := (self isReplace: string) ifTrue: [ at + 1 ] ifFalse: [ at ].
	
	^ (string copyFrom: 1  to: at), toInsert, (string copyFrom: from to: string size)

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
