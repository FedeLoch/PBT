Class {
	#name : 'UmePointGenerator',
	#superclass : 'UmeOptionsGenerator',
	#instVars : [
		'x',
		'y'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
UmePointGenerator >> fixedX: anX [

	x := anX.
]

{ #category : 'as yet unclassified' }
UmePointGenerator >> fixedY: anY [

	y := anY.
]

{ #category : 'as yet unclassified' }
UmePointGenerator >> gen: myConstraint [

	^ self genX @ (self genY)
]

{ #category : 'as yet unclassified' }
UmePointGenerator >> genX [

	^ x ifNil: [ range atRandom ] ifNotNil: [ x ]
]

{ #category : 'as yet unclassified' }
UmePointGenerator >> genY [

	^ y ifNil: [ range atRandom ] ifNotNil: [ y ]
]

{ #category : 'as yet unclassified' }
UmePointGenerator >> initialize [ 
	
	super initialize.
	range := (-100 to: 100)
]
