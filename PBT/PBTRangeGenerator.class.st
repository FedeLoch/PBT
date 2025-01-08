Class {
	#name : 'PBTRangeGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'range'
	],
	#category : 'PBT-Input Generation',
	#package : 'PBT',
	#tag : 'Input Generation'
}

{ #category : 'instance creation' }
PBTRangeGenerator >> from: aRange [

	range := aRange.
]

{ #category : 'as yet unclassified' }
PBTRangeGenerator >> gen: myConstraint [

	^ range atRandom
]
