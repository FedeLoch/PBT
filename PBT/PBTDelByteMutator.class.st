Class {
	#name : 'PBTDelByteMutator',
	#superclass : 'PBTStringMutator',
	#category : 'PBT-Mutators',
	#package : 'PBT',
	#tag : 'Mutators'
}

{ #category : 'accessing' }
PBTDelByteMutator >> applyMutation: target [

	| at |
	at := target size atRandom.
	
	^ (target copyFrom: 1 to: at - 1), (target copyFrom: at + 1 to: target size)
]
