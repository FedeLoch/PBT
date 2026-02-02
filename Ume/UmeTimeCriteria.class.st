Class {
	#name : 'UmeTimeCriteria',
	#superclass : 'UmeStopCriteria',
	#instVars : [
		'timeout'
	],
	#category : 'Ume-Runner',
	#package : 'Ume',
	#tag : 'Runner'
}

{ #category : 'asserting' }
UmeTimeCriteria >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	^ aTime milliSeconds < timeout 
]

{ #category : 'as yet unclassified' }
UmeTimeCriteria >> timeout: aTime [

	timeout := aTime
]
