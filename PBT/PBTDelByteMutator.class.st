Class {
	#name : 'PBTDelByteMutator',
	#superclass : 'PBTStringMutator',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTDelByteMutator >> applyMutation: target [

	| at |
	at := target size atRandom.
	
	^ (target copyFrom: 1 to: at - 1), (target copyFrom: at + 1 to: target size)
]
