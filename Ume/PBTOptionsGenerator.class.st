Class {
	#name : 'PBTOptionsGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'range'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTOptionsGenerator >> feed: feedback [

	"do nothing"
]

{ #category : 'instance creation' }
PBTOptionsGenerator >> from: aRange [

	range := aRange.
]

{ #category : 'as yet unclassified' }
PBTOptionsGenerator >> gen: myConstraint [

	^ range atRandom
]
