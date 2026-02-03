Class {
	#name : 'UmeByteFlipMutator',
	#superclass : 'UmeStringMutator',
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'accessing' }
UmeByteFlipMutator >> applyMutation: target [

	| at1 at2 temp |
	
	target ifEmpty: [ ^ target ].
	
	at1 := target size atRandom.
	at2 := target size atRandom.

	temp := target at: at1.
	target beWritableObject.
	target at: at1 put: (target at: at2).
	target at: at2 put: temp.
	
	^ target
]
