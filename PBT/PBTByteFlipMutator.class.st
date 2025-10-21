Class {
	#name : 'PBTByteFlipMutator',
	#superclass : 'PBTStringMutator',
	#category : 'PBT-Mutators',
	#package : 'PBT',
	#tag : 'Mutators'
}

{ #category : 'accessing' }
PBTByteFlipMutator >> applyMutation: target [

	| at1 at2 temp |
	at1 := target size atRandom.
	at2 := target size atRandom.

	temp := target at: at1.
	target beWritableObject.
	target at: at1 put: (target at: at2).
	target at: at2 put: temp.
	
	^ target
]
