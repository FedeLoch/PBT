Class {
	#name : 'PBTByteFlipMutator',
	#superclass : 'PBTStringMutator',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTByteFlipMutator >> applyMutation: target [

	| at1 at2 temp |
	at1 := target size atRandom.
	at2 := target size atRandom.

	temp := target at: at1.
	^ String streamContents: [ :stream |
		  1 to: target size do: [ :k |
			  | c |
			  c := k = at1
				       ifTrue: [ target at: at2 ]
				       ifFalse: [
					       k = at2
						       ifTrue: [ temp ]
						       ifFalse: [ target at: k ] ].
			  stream nextPut: c ] ]
]
