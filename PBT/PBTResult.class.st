Class {
	#name : 'PBTResult',
	#superclass : 'Object',
	#instVars : [
		'tests',
		'totalTime',
		'totalCoverage',
		'performanceResult',
		'segmentedTests',
		'ranking'
	],
	#category : 'PBT-Result',
	#package : 'PBT',
	#tag : 'Result'
}

{ #category : 'as yet unclassified' }
PBTResult class >> resultFrom: tests since: time withCoverage: totalCoverageResult [

	| totalTime perfResult |
	
	totalTime := Duration milliSeconds: (Time millisecondsSince: time).
	perfResult := PerformanceResult from: tests withTime: totalTime.
	
	^ self new tests: tests;
		totalTime: totalTime;
		totalCoverage: totalCoverageResult;
		ranking: (tests collect: [ :test | test score ifNil: [ 0 ] ifNotNil: [ test score ] ]) asSortedCollection reverse;
		performanceResult: perfResult
]

{ #category : 'as yet unclassified' }
PBTResult >> performanceResult: aPerfResult [

	performanceResult := aPerfResult

]

{ #category : 'as yet unclassified' }
PBTResult >> plotBy: x and: y [
	
	| composite plot |
	
	composite := RSCompositeChart new.
	plot := RSScatterPlot new x: x y: y.
	^ plot
]

{ #category : 'as yet unclassified' }
PBTResult >> plotByAllocatedMemory [

	^ self plotBy: (1 to: tests size) and: (tests collect: [ :test | test result allocatedMemory ])
]

{ #category : 'as yet unclassified' }
PBTResult >> plotByCoverage [

	^ self plotBy: (1 to: tests size) and: (tests collect: [ :test |
		test result coverageResult ifNil: [ 0 ] ifNotNil: [ test result coverageResult percentage ] ])
]

{ #category : 'as yet unclassified' }
PBTResult >> plotByExecutionTime [
	
	^ self plotBy: (1 to: tests size) and: (tests collect: [ :test | test time asMilliSeconds ])

]

{ #category : 'as yet unclassified' }
PBTResult >> plotByScore [
	
	^ self plotBy: (1 to: tests size) and: (tests collect: [ :test | test score ])

]

{ #category : 'as yet unclassified' }
PBTResult >> ranking [

	^ ranking
]

{ #category : 'as yet unclassified' }
PBTResult >> ranking: aRanking [

	ranking := aRanking

]

{ #category : 'as yet unclassified' }
PBTResult >> tests [

	^ tests 
]

{ #category : 'as yet unclassified' }
PBTResult >> tests: someTests [

	tests := someTests.
	segmentedTests := someTests groupedBy: [ :test | test result class ].
]

{ #category : 'as yet unclassified' }
PBTResult >> totalCoverage [

	^ totalCoverage 
]

{ #category : 'as yet unclassified' }
PBTResult >> totalCoverage: aTotalCoverage [

	totalCoverage := aTotalCoverage

]

{ #category : 'as yet unclassified' }
PBTResult >> totalTime [

	^ totalTime 
]

{ #category : 'as yet unclassified' }
PBTResult >> totalTime: aTotalTime [

	totalTime := aTotalTime

]
