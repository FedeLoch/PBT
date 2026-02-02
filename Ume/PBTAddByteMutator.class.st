Class {
	#name : 'PBTAddByteMutator',
	#superclass : 'PBTAddElementMutator',
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'accessing' }
PBTAddByteMutator >> initialize [ 

	super initialize.
	options := (33 to: 126) collect: [ :v | ( Character value: v ) asString ]
]
