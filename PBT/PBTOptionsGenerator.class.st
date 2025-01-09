Class {
	#name : 'PBTOptionsGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'range'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
PBTOptionsGenerator >> from: aRange [

	range := aRange.
]

{ #category : 'as yet unclassified' }
PBTOptionsGenerator >> gen: myConstraint [

	^ range atRandom
]