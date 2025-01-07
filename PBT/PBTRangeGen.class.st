Class {
	#name : 'PBTRangeGen',
	#superclass : 'PBTGen',
	#instVars : [
		'range'
	],
	#category : 'PBT-Input Generation',
	#package : 'PBT',
	#tag : 'Input Generation'
}

{ #category : 'instance creation' }
PBTRangeGen >> from: aRange [

	range := aRange.
]

{ #category : 'as yet unclassified' }
PBTRangeGen >> gen [ 

	^ range atRandom
]
