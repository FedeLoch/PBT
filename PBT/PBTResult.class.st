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
PBTResult >> lineplotBy: xBlock and: ybloc xlabel: xLabel ylabel: yLabel title: title [

"	| popup container |
	
	container := RSCompositeChart new.
	popup := RSPopupDecoration new.

	container add:(RSScatterPlot new
		  rawData: tests x: xBlock y: ybloc;
		  xlabel: xLabel;
		  ylabel: yLabel;
		  title: title;
		  yourself).
		
	container addDecoration: popup.
	^ container"
	
	^ RSLinePlot new
		  rawData: tests x: xBlock y: ybloc;
		  xlabel: xLabel;
		  ylabel: yLabel;
		  title: title;
		  yourself
]

{ #category : 'as yet unclassified' }
PBTResult >> performanceResult: aPerfResult [

	performanceResult := aPerfResult

]

{ #category : 'as yet unclassified' }
PBTResult >> plotBy: xBlock and: ybloc xlabel: xLabel ylabel: yLabel title: title [

"	| popup container |
	
	container := RSCompositeChart new.
	popup := RSPopupDecoration new.

	container add:(RSScatterPlot new
		  rawData: tests x: xBlock y: ybloc;
		  xlabel: xLabel;
		  ylabel: yLabel;
		  title: title;
		  yourself).
		
	container addDecoration: popup.
	^ container"
	
	^ RSScatterPlot new
		  rawData: tests x: xBlock y: ybloc;
		  xlabel: xLabel;
		  ylabel: yLabel;
		  title: title;
		  yourself
]

{ #category : 'as yet unclassified' }
PBTResult >> plotByAccumulatedCoverage [

	| result |
	result := IncrementalCoverageResult for: { } from: tests first result coverageResult collector. 
	^ self
		  lineplotBy: [ :test | tests indexOf: test ]
		  and: [ :test |
			result incrementWith: test result coverageResult. 
			result percentage ]
		  xlabel: 'Number of cases'
		  ylabel: 'Incremental coverage achieved'
		  title: 'Total coverage achieved'
]

{ #category : 'as yet unclassified' }
PBTResult >> plotByAllocatedMemory [

	^ self
		  lineplotBy: [ :test | tests indexOf: test ]
		  and: [ :test | test result allocatedMemory ]
		  xlabel: 'Number of cases'
		  ylabel: 'Allocated memory'
		  title: 'Allocated memory per case'
]

{ #category : 'as yet unclassified' }
PBTResult >> plotByCoverage [

	^ self
		  plotBy: [ :test | tests indexOf: test ]
		  and: [ :test |
				   test result coverageResult
					   ifNil: [ 0 ]
					   ifNotNil: [ test result coverageResult percentage ] ]
		  xlabel: 'Number of cases'
		  ylabel: 'Coverage achieved'
		  title: 'Coverage achieved per case'
]

{ #category : 'as yet unclassified' }
PBTResult >> plotByExecutionTime [

	^ self
		  lineplotBy: [ :test | tests indexOf: test ]
		  and: [ :test | test time asMilliSeconds ]
		  xlabel: 'Number of cases'
		  ylabel: 'Time consumed'
		  title: 'Execution time consumed per case'
]

{ #category : 'as yet unclassified' }
PBTResult >> plotByScore [

	^ self
		  lineplotBy: [ :test | tests indexOf: test ]
		  and: [ :test | test score ]
		  xlabel: 'Number of cases'
		  ylabel: 'Score'
		  title: 'Ranking'
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
