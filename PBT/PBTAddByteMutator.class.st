Class {
	#name : 'PBTAddByteMutator',
	#superclass : 'PBTAddElementMutator',
	#category : 'PBT-Mutators',
	#package : 'PBT',
	#tag : 'Mutators'
}

{ #category : 'accessing' }
PBTAddByteMutator >> initialize [ 

	super initialize.
	options := (33 to: 126) collect: [ :v | ( Character value: v ) asString ]
]
