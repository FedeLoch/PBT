Class {
	#name : 'PerformanceResult',
	#superclass : 'Object',
	#instVars : [
		'averageTime',
		'maxTime',
		'minTime',
		'totalTime',
		'segmentedTests'
	],
	#category : 'PBT-Result',
	#package : 'PBT',
	#tag : 'Result'
}

{ #category : 'instance creation' }
PerformanceResult class >> from: tests withTime: totalTime [
	
	| times |
	
	times := tests collect: #time.
	^ self new totalTime: totalTime;
		averageTime: (totalTime / tests size); 
		segmentedTests: (tests groupedBy: #time);
		maxTime: times max;
		minTime: times min
]

{ #category : 'accessing' }
PerformanceResult >> averageTime: aTime [

	averageTime := aTime
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
