Class {
	#name : 'PerformanceResult',
	#superclass : 'Object',
	#instVars : [
		'averageTime',
		'maxTime',
		'minTime',
		'totalTime',
		'segmentedTests',
		'worstCase',
		'betterCase'
	],
	#category : 'PBT-Result',
	#package : 'PBT',
	#tag : 'Result'
}

{ #category : 'instance creation' }
PerformanceResult class >> from: tests withTime: totalTime [
	
	| worstAndBetter |
	
	worstAndBetter := tests inject: {} into: [ :worstBetter :case |
		worstBetter ifEmpty: [ { case . case } ] ifNotEmpty: [ {
			(case time > worstBetter first time) ifTrue: [ case ] ifFalse: [ worstBetter first ].
			(case time < worstBetter last time) ifTrue: [ case ] ifFalse: [ worstBetter last ].
		}]
	].

	^ self new totalTime: totalTime;
		averageTime: (totalTime / tests size); 
		segmentedTests: (tests groupedBy: #time);
		worstCase: worstAndBetter first;
		maxTime: worstAndBetter first time;
		betterCase: worstAndBetter last;
		minTime: worstAndBetter last time
]

{ #category : 'accessing' }
PerformanceResult >> averageTime: aTime [

	averageTime := aTime
]

{ #category : 'accessing' }
PerformanceResult >> betterCase: aCase [

	betterCase := aCase 
]

{ #category : 'accessing' }
PerformanceResult >> maxTime: aTime [

	maxTime := aTime
]

{ #category : 'accessing' }
PerformanceResult >> minTime: aTime [

	minTime := aTime
]

{ #category : 'accessing' }
PerformanceResult >> segmentedTests: segmented [

	segmentedTests := segmented associations
]

{ #category : 'accessing' }
PerformanceResult >> totalTime: aTime [

	totalTime := aTime
]

{ #category : 'accessing' }
PerformanceResult >> worstCase: aCase [

	worstCase := aCase 
]
