Class {
	#name : 'PBTCountCriteria',
	#superclass : 'PBTStopCriteria',
	#instVars : [
		'times'
	],
	#category : 'PBT-Runner',
	#package : 'PBT',
	#tag : 'Runner'
}

{ #category : 'asserting' }
PBTCountCriteria >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	^ currentTests size < times
]

{ #category : 'as yet unclassified' }
PBTCountCriteria >> times: aCount [

	times := aCount
]
