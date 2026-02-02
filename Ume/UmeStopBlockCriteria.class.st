Class {
	#name : 'UmeStopBlockCriteria',
	#superclass : 'UmeStopCriteria',
	#instVars : [
		'block'
	],
	#category : 'Ume-Runner',
	#package : 'Ume',
	#tag : 'Runner'
}

{ #category : 'accessing' }
UmeStopBlockCriteria >> block: aBlock [

	block := aBlock 
]

{ #category : 'asserting' }
UmeStopBlockCriteria >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	^ block value: currentTests value: aTime value: aCoverage 
]
