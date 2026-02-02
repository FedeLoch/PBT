Class {
	#name : 'UmeOptionsGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'range'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
UmeOptionsGenerator >> feed: feedback [

	"do nothing"
]

{ #category : 'instance creation' }
UmeOptionsGenerator >> from: aRange [

	range := aRange.
]

{ #category : 'as yet unclassified' }
UmeOptionsGenerator >> gen: myConstraint [

	^ range atRandom
]
