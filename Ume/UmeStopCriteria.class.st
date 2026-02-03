Class {
	#name : 'UmeStopCriteria',
	#superclass : 'Object',
	#category : 'Ume-Runner',
	#package : 'Ume',
	#tag : 'Runner'
}

{ #category : 'asserting' }
UmeStopCriteria >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	^ self subclassResponsibility 
]
