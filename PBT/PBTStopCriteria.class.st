Class {
	#name : 'PBTStopCriteria',
	#superclass : 'Object',
	#category : 'PBT-Runner',
	#package : 'PBT',
	#tag : 'Runner'
}

{ #category : 'asserting' }
PBTStopCriteria >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	^ self subclassResponsibility 
]
