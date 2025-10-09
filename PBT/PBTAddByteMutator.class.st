Class {
	#name : 'PBTAddByteMutator',
	#superclass : 'PBTAddElementMutator',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTAddByteMutator >> initialize [ 

	super initialize.
	options := (33 to: 126) collect: [ :v | ( Character value: v ) asString ]
]
