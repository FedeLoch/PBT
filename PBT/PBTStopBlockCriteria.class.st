Class {
	#name : 'PBTStopBlockCriteria',
	#superclass : 'PBTStopCriteria',
	#instVars : [
		'block'
	],
	#category : 'PBT-Runner',
	#package : 'PBT',
	#tag : 'Runner'
}

{ #category : 'accessing' }
PBTStopBlockCriteria >> block: aBlock [

	block := aBlock 
]

{ #category : 'asserting' }
PBTStopBlockCriteria >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	^ block value: currentTests value: aTime value: aCoverage 
]
