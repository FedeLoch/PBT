Class {
	#name : 'PBTMockAnalyzer',
	#superclass : 'Object',
	#category : 'PBT-Shrinking',
	#package : 'PBT',
	#tag : 'Shrinking'
}

{ #category : 'analysis' }
PBTMockAnalyzer >> analyze: input [
	"Simulate profiling. If input has depth > 2, return high cost."
	| depth |
	depth := input occurrencesOf: $[.
	^ Dictionary new 
		at: #executionTime put: (depth > 2 ifTrue: [ 1000 ] ifFalse: [ 10 ]);
		yourself
]

Class {
	#name : 'PBTMockEvaluator',
	#superclass : 'Object',
	#instVars : [ 'analyzer' ],
	#category : 'PBT-Shrinking',
	#package : 'PBT',
	#tag : 'Shrinking'
}

{ #category : 'accessing' }
PBTMockEvaluator >> analyzer [
	^ analyzer ifNil: [ analyzer := PBTMockAnalyzer new ]
]
