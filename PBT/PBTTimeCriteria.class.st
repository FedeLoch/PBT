Class {
	#name : 'PBTTimeCriteria',
	#superclass : 'PBTStopCriteria',
	#instVars : [
		'timeout'
	],
	#category : 'PBT-Runner',
	#package : 'PBT',
	#tag : 'Runner'
}

{ #category : 'asserting' }
PBTTimeCriteria >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	^ aTime milliSeconds < timeout 
]

{ #category : 'as yet unclassified' }
PBTTimeCriteria >> timeout: aTime [

	timeout := aTime
]
