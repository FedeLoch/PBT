Class {
	#name : 'PBTResult',
	#superclass : 'Object',
	#instVars : [
		'tests',
		'totalTime',
		'totalCoverage'
	],
	#category : 'PBT-Result',
	#package : 'PBT',
	#tag : 'Result'
}

{ #category : 'as yet unclassified' }
PBTResult class >> resultFrom: tests since: time withCoverage: totalCoverageResult [

	| milliseconds |
	"TODO: Improve this"
	milliseconds := (Time millisecondsSince: time).
	^ self new tests: tests; totalTime: (Duration milliSeconds: milliseconds); totalCoverage: totalCoverageResult 
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
