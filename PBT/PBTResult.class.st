Class {
	#name : 'PBTResult',
	#superclass : 'Object',
	#instVars : [
		'tests',
		'totalTime',
		'totalCoverage',
		'performanceResult',
		'segmentedTests',
		'ranking',
		'schema',
		'topCases'
	],
	#category : 'PBT-Result',
	#package : 'PBT',
	#tag : 'Result'
}

{ #category : 'as yet unclassified' }
PBTResult class >> resultFrom: tests since: time withCoverage: totalCoverageResult andSchema: schema [

	| totalTime perfResult topCases |
	
	totalTime := Duration milliSeconds: (Time millisecondsSince: time).
	perfResult := PerformanceResult from: tests withTime: totalTime.
	topCases := tests allButFirst inject: { tests first } asOrderedCollection into: [ :col :test |
		((schema feedbackEvaluator value: test) > (schema feedbackEvaluator value: col last)) ifTrue: [ col add: test ]. col ].
	
	^ self new tests: tests;
		totalTime: totalTime;
		totalCoverage: totalCoverageResult;
		topCases: topCases;
		ranking: (tests collect: [ :test | test score ifNil: [ 0 ] ifNotNil: [ test score ] ]) asSortedCollection reverse;
		schema: schema;
		performanceResult: perfResult
]

{ #category : 'as yet unclassified' }
PBTResult >> exportExecutionValues [

	| writer total |
	'exportExecutionValues.csv' asFileReference writeStreamDo: [ :stream |
		writer := (NeoCSVWriter on: stream)
			writeHeader: #( testStartTime totalMilliseconds );
			fieldWriter: #raw;
			yourself.
		total := 0.
		tests do: [ :test |
			total := (total + test time asMilliSeconds) max: 0.
			writer nextPut: {
					total.
					test time asMilliSeconds } ] ]
]

{ #category : 'plot' }
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
		  rawData: tests x: xBlock y: ybloc; yLog;
		  xlabel: xLabel;
		  ylabel: yLabel;
		  title: title;
		  yourself
]

{ #category : 'as yet unclassified' }
PBTResult >> minimumTimeNeeded [

	^ (topCases collect: [ :test | test result time ]) sum
]

{ #category : 'outliers' }
PBTResult >> outliersBy: valueBlock [

	| sortedTests q1 q3 iqr upperBound min |
	
	sortedTests := tests sorted: [ :a :b | (valueBlock value: a) < (valueBlock value: b) ].
	
	min := valueBlock value: (sortedTests first).
	"We are ignoring cases with min values, the idea is to avoid biased the sample"
	sortedTests := sortedTests select: [ :test | (valueBlock value: test) > min ].

	sortedTests ifEmpty: [ ^sortedTests ].
	
	q1 := (valueBlock value: (sortedTests at: (sortedTests size * 0.25) ceiling)).
	q3 := (valueBlock value: (sortedTests at: (sortedTests size * 0.75) ceiling)).

	iqr := q3 - q1.
	upperBound := q3 + (1.5 * iqr).

	^ sortedTests select: [ :each | (valueBlock value: each) > upperBound ]
]

{ #category : 'outliers' }
PBTResult >> outliersByAllocatedMemory [

	^ self outliersBy: [ : test | test result allocatedMemory ]
]

{ #category : 'outliers' }
PBTResult >> outliersByCoverage [

	^ self outliersBy: [ :test |
		  test result coverageResult
			  ifNil: [ 0 ]
			  ifNotNil: [ test result coverageResult percentage ] ]
]

{ #category : 'outliers' }
PBTResult >> outliersByExecutionTime [

	^ self outliersBy: [ : test | test time asMilliSeconds ]
]

{ #category : 'outliers' }
PBTResult >> outliersByScore [

	^ self outliersBy: [ : test | test score max: 0 ]
]

{ #category : 'setter' }
PBTResult >> performanceResult: aPerfResult [

	performanceResult := aPerfResult

]

{ #category : 'plot' }
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

{ #category : 'plot' }
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

{ #category : 'plot' }
PBTResult >> plotByAllocatedMemory [

	^ self
		  lineplotBy: [ :test | tests indexOf: test ]
		  and: [ :test | test result allocatedMemory ]
		  xlabel: 'Number of cases'
		  ylabel: 'Allocated memory'
		  title: 'Allocated memory per case'
]

{ #category : 'plot' }
PBTResult >> plotByCoverage [

	^ self
		  lineplotBy: [ :test | tests indexOf: test ]
		  and: [ :test |
				   test result coverageResult
					   ifNil: [ 0 ]
					   ifNotNil: [ test result coverageResult percentage ] ]
		  xlabel: 'Number of cases'
		  ylabel: 'Coverage achieved'
		  title: 'Coverage achieved per case'
]

{ #category : 'plot' }
PBTResult >> plotByExecutionTime [

	| total |
	total := 0.
	
	^ self
		  lineplotBy: [ :test | total := total + test time asMilliSeconds. total ]
		  and: [ :test | test time asMilliSeconds ]
		  xlabel: 'Number of cases'
		  ylabel: 'Time consumed'
		  title: 'Execution time consumed per case'
]

{ #category : 'plot' }
PBTResult >> plotByFeedback [

	^ self
		  plotBy: [ :test | tests indexOf: test ]
		  and: [ :test | test feedback ifTrue: [ schema feedbackEvaluator value: test ] ifFalse: [ 0 ] ]
		  xlabel: 'Number of cases'
		  ylabel: 'Improves last better solution'
		  title: 'Improvement of global case'
]

{ #category : 'plot' }
PBTResult >> plotByScore [

	^ self
		  lineplotBy: [ :test | tests indexOf: test ]
		  and: [ :test | test score ]
		  xlabel: 'Number of cases'
		  ylabel: 'Score'
		  title: 'Ranking'
]

{ #category : 'plot' }
PBTResult >> plotOutliers [

	| scoreOutliers allocatedMemoryOutliers executionTimeOutliers coverageOutliers scorePlot allocatedMemoryPlot executionTimeOutliersPlot coverageOutliersPlot canvas |
	
	scoreOutliers := self outliersByScore.
	allocatedMemoryOutliers := self outliersByAllocatedMemory.
	executionTimeOutliers := self outliersByExecutionTime.
	coverageOutliers := self outliersByCoverage.

	scorePlot := RSBoxPlot new y: (scoreOutliers ifEmpty: [ { 1 } ] ifNotEmpty: [ (scoreOutliers collect: [ :t | t score ]) ]); yLog; yourself.
	scorePlot horizontalTick numberOfTicks: scoreOutliers size.
	scorePlot ylabel: 'Score'; xlabel: '( ', scoreOutliers size asString, ' cases )'.
	
	allocatedMemoryPlot := RSBoxPlot new y: (allocatedMemoryOutliers ifEmpty: [ { 1 } ] ifNotEmpty: [ (allocatedMemoryOutliers collect: [ :t | t result allocatedMemory ]) ]); yLog; yourself.
	allocatedMemoryPlot horizontalTick numberOfTicks: allocatedMemoryOutliers size.
	allocatedMemoryPlot ylabel: 'Allocated memory'; xlabel: '( ', allocatedMemoryOutliers size asString, ' cases )'.
	
	executionTimeOutliersPlot := RSBoxPlot new y: (executionTimeOutliers ifEmpty: [ { 1 } ] ifNotEmpty: [ (executionTimeOutliers collect: [ :t | t result time asMilliSeconds ]) ]); yLog; yourself.
	executionTimeOutliersPlot horizontalTick numberOfTicks: executionTimeOutliers size.
	executionTimeOutliersPlot ylabel: 'Time execution in milliseconds'; xlabel: '( ', executionTimeOutliers size asString, ' cases )'.
	
	coverageOutliersPlot := RSBoxPlot new y: (coverageOutliers ifEmpty: [ { 1 } ] ifNotEmpty: [ (coverageOutliers collect: [ :t | t result coverageResult percentage ]) ]); yLog; yourself.
	coverageOutliersPlot horizontalTick numberOfTicks: coverageOutliers size.
	coverageOutliersPlot ylabel: 'Coverage reached'; xlabel: '( ', coverageOutliers size asString, ' cases )'.
		
	canvas := RSCanvas new @ RSCanvasController.
	canvas addAll: {  scorePlot asShape . allocatedMemoryPlot asShape . executionTimeOutliersPlot asShape . coverageOutliersPlot asShape }.
	
	RSHorizontalLineLayout new alignBottom; on: canvas shapes.
	
	^ canvas

]

{ #category : 'getter' }
PBTResult >> ranking [

	^ ranking
]

{ #category : 'setter' }
PBTResult >> ranking: aRanking [

	ranking := aRanking

]

{ #category : 'getter' }
PBTResult >> schema [

	^ schema 
]

{ #category : 'setter' }
PBTResult >> schema: aSchema [

	schema := aSchema
]

{ #category : 'getter' }
PBTResult >> tests [

	^ tests 
]

{ #category : 'setter' }
PBTResult >> tests: someTests [

	tests := someTests.
	segmentedTests := someTests groupedBy: [ :test | test result class ].
]

{ #category : 'getter' }
PBTResult >> topCases [

	^ topCases 
]

{ #category : 'setter' }
PBTResult >> topCases: someTopCases [

	topCases := someTopCases 
]

{ #category : 'getter' }
PBTResult >> totalCoverage [

	^ totalCoverage 
]

{ #category : 'setter' }
PBTResult >> totalCoverage: aTotalCoverage [

	totalCoverage := aTotalCoverage

]

{ #category : 'getter' }
PBTResult >> totalTime [

	^ totalTime 
]

{ #category : 'setter' }
PBTResult >> totalTime: aTotalTime [

	totalTime := aTotalTime

]

{ #category : 'as yet unclassified' }
PBTResult >> unnecessaryExplorationTime [

	^ totalTime - self minimumTimeNeeded 
]
