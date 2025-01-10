Class {
	#name : 'PBTResult',
	#superclass : 'Object',
	#instVars : [
		'tests',
		'totalTime',
		'totalCoverage',
		'performanceResult'
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
		performanceResult: perfResult
]

{ #category : 'as yet unclassified' }
PBTResult >> performanceResult: aPerfResult [

	performanceResult := aPerfResult

]

{ #category : 'as yet unclassified' }
PBTResult >> tests [

	^ tests 
]

{ #category : 'as yet unclassified' }
PBTResult >> tests: someTests [

	tests := someTests

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
