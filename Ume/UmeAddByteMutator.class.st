Class {
	#name : 'UmeAddByteMutator',
	#superclass : 'UmeAddElementMutator',
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'accessing' }
UmeAddByteMutator >> initialize [ 

	super initialize.
	options := (33 to: 126) collect: [ :v | ( Character value: v ) asString ]
]
