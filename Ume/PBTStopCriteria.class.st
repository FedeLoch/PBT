Class {
	#name : 'PBTStopCriteria',
	#superclass : 'Object',
	#category : 'Ume-Runner',
	#package : 'Ume',
	#tag : 'Runner'
}

{ #category : 'asserting' }
PBTStopCriteria >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	^ self subclassResponsibility 
]
