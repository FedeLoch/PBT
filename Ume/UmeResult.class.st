Class {
	#name : 'UmeResult',
	#superclass : 'Object',
	#instVars : [
		'tests',
		'totalTime',
		'totalCoverage',
		'performanceResult',
		'segmentedTests',
		'ranking',
		'topCases',
		'feedbackEvaluator',
		'runner'
	],
	#category : 'Ume-Result',
	#package : 'Ume',
	#tag : 'Result'
}

{ #category : 'as yet unclassified' }
UmeResult class >> resultFrom: tests since: time withCoverage: totalCoverageResult runner: runner [

	| totalTime perfResult topCases |
	
	totalTime := Duration milliSeconds: (Time millisecondsSince: time).
	perfResult := PerformanceResult from: tests withTime: totalTime.
	topCases := runner feedbackEvaluator topCases.

	^ self new tests: tests;
		totalTime: totalTime;
		totalCoverage: totalCoverageResult;
		topCases: topCases;
		runner: runner;
		feedbackEvaluator: runner feedbackEvaluator;
		ranking: (tests collect: [ :test | test score ifNil: [ 0 ] ifNotNil: [ test score ] ]) asSortedCollection reverse;
		performanceResult: perfResult
]

{ #category : 'as yet unclassified' }
UmeResult >> bloxplotByTime [
	
	| plot |
	plot := RSBoxPlot new y: self times; yLog; yourself.
	plot horizontalTick numberOfTicks: tests size.
	
	^ plot open
]

{ #category : 'as yet unclassified' }
UmeResult >> continue: numberOfCases [

	^ runner continue: numberOfCases from: self
]

{ #category : 'as yet unclassified' }
UmeResult >> continueFor: time [

	^ runner continueFor: time from: self
]

{ #category : 'as yet unclassified' }
UmeResult >> exportAsCSV [

	self exportAsCSV: (self hash asString, '-results.csv')
]

{ #category : 'as yet unclassified' }
UmeResult >> exportAsCSV: fileName [

	| writer |
	
	fileName asFileReference writeStreamDo: [ :stream |
		writer := (NeoCSVWriter on: stream)
			writeHeader: #( 'time-microseconds' 'improvement' );
			fieldWriter: #raw;
			yourself.
			
		tests do: [ :test |
			writer nextPut: {
					test time asMicroseconds.
					test feedback improvement } ] ]
]

{ #category : 'as yet unclassified' }
UmeResult >> exportExecutionValues [

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

{ #category : 'as yet unclassified' }
UmeResult >> feed: someTests time: aTime [ 

	tests := tests, someTests.
	totalTime := totalTime  + (Duration milliSeconds: (Time millisecondsSince: aTime)).
	performanceResult := PerformanceResult from: tests withTime: totalTime.
	topCases := runner feedbackEvaluator topCases.
	ranking := (tests collect: [ :test | test score ifNil: [ 0 ] ifNotNil: [ test score ] ]) asSortedCollection reverse.
]

{ #category : 'accessing' }
UmeResult >> feedbackEvaluator [
	
	^ feedbackEvaluator
]

{ #category : 'setter' }
UmeResult >> feedbackEvaluator: aFeedbackEvaluator [

	feedbackEvaluator := aFeedbackEvaluator

]

{ #category : 'plot' }
UmeResult >> lineplotBy: xBlock and: ybloc xlabel: xLabel ylabel: yLabel title: title [

	^ RSLinePlot new
		  rawData: tests x: xBlock y: ybloc; yLog;
		  xlabel: xLabel;
		  ylabel: yLabel;
		  title: title;
		  open
]

{ #category : 'as yet unclassified' }
UmeResult >> minimumTimeNeeded [

	^ (topCases collect: [ :test | test result time ]) sum
]

{ #category : 'as yet unclassified' }
UmeResult >> mutalkTest [

	^ MTTestUmeCaseReference for: (UmeTestsuit from: tests)
]

{ #category : 'outliers' }
UmeResult >> outliersBy: valueBlock [

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
UmeResult >> outliersByAllocatedMemory [

	^ self outliersBy: [ : test | test result allocatedMemory ]
]

{ #category : 'outliers' }
UmeResult >> outliersByCoverage [

	^ self outliersBy: [ :test |
		  test result coverageResult
			  ifNil: [ 0 ]
			  ifNotNil: [ test result coverageResult percentage ] ]
]

{ #category : 'outliers' }
UmeResult >> outliersByExecutionTime [

	^ self outliersBy: [ : test | test time asMilliSeconds ]
]

{ #category : 'outliers' }
UmeResult >> outliersByScore [

	^ self outliersBy: [ : test | test score max: 0 ]
]

{ #category : 'setter' }
UmeResult >> performanceResult: aPerfResult [

	performanceResult := aPerfResult

]

{ #category : 'plot' }
UmeResult >> plotBy: xBlock and: ybloc xlabel: xLabel ylabel: yLabel title: title [

	^ RSScatterPlot new
		  rawData: tests x: xBlock y: ybloc;
		  xlabel: xLabel;
		  ylabel: yLabel;
		  title: title;
		  yourself
]

{ #category : 'plot' }
UmeResult >> plotByAccumulatedCoverage [

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
UmeResult >> plotByAllocatedMemory [

	^ self
		  lineplotBy: [ :test | tests indexOf: test ]
		  and: [ :test | test result allocatedMemory ]
		  xlabel: 'Number of cases'
		  ylabel: 'Allocated memory'
		  title: 'Allocated memory per case'
]

{ #category : 'plot' }
UmeResult >> plotByCoverage [
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
UmeResult >> plotByExecutionTime [

	| total |
	total := 0.
	
	^ self
		  lineplotBy: [ :test | total := total + test time asMilliSeconds. total ]
		  and: [ :test | test time asMilliSeconds ]
		  xlabel: 'Number of cases'
		  ylabel: 'Time consumed'
		  title: 'Execution time consumed per case'
]

{ #category : 'as yet unclassified' }
UmeResult >> plotByImprovements [
	
	^ self
		  lineplotBy: [ :test | tests indexOf: test ]
		  and: [ :test | test feedback improvement ]
		  xlabel: 'Number of cases'
		  ylabel: 'Sum of categories'
		  title: 'Categories reached per case'
]

{ #category : 'plot' }
UmeResult >> plotByScore [

	^ self
		  lineplotBy: [ :test | tests indexOf: test ]
		  and: [ :test | test score ]
		  xlabel: 'Number of cases'
		  ylabel: 'Score'
		  title: 'Ranking'
]

{ #category : 'plot' }
UmeResult >> plotOutliers [

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
UmeResult >> ranking [

	^ ranking
]

{ #category : 'setter' }
UmeResult >> ranking: aRanking [

	ranking := aRanking

]

{ #category : 'outliers' }
UmeResult >> runner: aRunner [

	runner := aRunner 
]

{ #category : 'getter' }
UmeResult >> tests [

	^ tests 
]

{ #category : 'setter' }
UmeResult >> tests: someTests [

	tests := someTests.
	segmentedTests := someTests groupedBy: [ :test | test result class ].
]

{ #category : 'as yet unclassified' }
UmeResult >> times [
	
	^ tests collect: [ :t | t result time asMilliSeconds ]
]

{ #category : 'getter' }
UmeResult >> topCases [

	^ topCases 
]

{ #category : 'setter' }
UmeResult >> topCases: someTopCases [

	topCases := someTopCases 
]

{ #category : 'getter' }
UmeResult >> totalCoverage [

	^ totalCoverage 
]

{ #category : 'setter' }
UmeResult >> totalCoverage: aTotalCoverage [

	totalCoverage := aTotalCoverage

]

{ #category : 'getter' }
UmeResult >> totalTime [

	^ totalTime 
]

{ #category : 'setter' }
UmeResult >> totalTime: aTotalTime [

	totalTime := aTotalTime

]

{ #category : 'as yet unclassified' }
UmeResult >> unnecessaryExplorationTime [

	^ totalTime - self minimumTimeNeeded 
]

{ #category : 'writing' }
UmeResult >> writeToFile: fileName [

	| file |
	
	file := fileName asFileReference.
	file ensureDelete.
	file writeStreamDo: [ :stream | STON put: self onStreamPretty: stream ].
	
	^ file
	
]
