Class {
	#name : 'PBTOptionsGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'range'
	],
	#category : 'PBT-Input Generation',
	#package : 'PBT',
	#tag : 'Input Generation'
}

{ #category : 'instance creation' }
PBTOptionsGenerator >> from: aRange [

	range := aRange.
]

{ #category : 'as yet unclassified' }
PBTOptionsGenerator >> gen: myConstraint [

	^ range atRandom
]
