Class {
	#name : 'PBTDelByteMutator',
	#superclass : 'PBTStringMutator',
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'accessing' }
PBTDelByteMutator >> applyMutation: target [

	| at |
	
	target ifEmpty: [ ^ target ].
	
	at := target size atRandom.
	
	^ (target copyFrom: 1 to: at - 1), (target copyFrom: at + 1 to: target size)
]
