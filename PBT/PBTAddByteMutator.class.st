Class {
	#name : 'PBTAddByteMutator',
	#superclass : 'PBTStringMutator',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTAddByteMutator >> applyMutation: target [

	| at |
	
	at := target size atRandom.
	
	^ (target copyFrom: 1  to: at), (1 to: 126) atRandom asCharacter asString, (target copyFrom: at to: target size)

]
