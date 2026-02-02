Class {
	#name : 'PBTPointGenerator',
	#superclass : 'PBTOptionsGenerator',
	#instVars : [
		'x',
		'y'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTPointGenerator >> fixedX: anX [

	x := anX.
]

{ #category : 'as yet unclassified' }
PBTPointGenerator >> fixedY: anY [

	y := anY.
]

{ #category : 'as yet unclassified' }
PBTPointGenerator >> gen: myConstraint [

	^ self genX @ (self genY)
]

{ #category : 'as yet unclassified' }
PBTPointGenerator >> genX [

	^ x ifNil: [ range atRandom ] ifNotNil: [ x ]
]

{ #category : 'as yet unclassified' }
PBTPointGenerator >> genY [

	^ y ifNil: [ range atRandom ] ifNotNil: [ y ]
]

{ #category : 'as yet unclassified' }
PBTPointGenerator >> initialize [ 
	
	super initialize.
	range := (-100 to: 100)
]
