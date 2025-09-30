Class {
	#name : 'PBTFeedbackEvaluator',
	#superclass : 'Object',
	#instVars : [
		'methodsCalled',
		'topCases',
		'guide',
		'memoryTable',
		'coverageTable',
		'performanceTable',
		'customMetricsTable'
	],
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'instance creation' }
PBTFeedbackEvaluator class >> from: aBlock [

	^ self new criteria: aBlock 
]

{ #category : 'ston-core' }
PBTFeedbackEvaluator class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( criteria )
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> category: value [
	
	value == 0 ifTrue: [ ^ 0 ].

	^ value ln rounded
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> compareAndUpdateValues: caseValues [

	^ caseValues keys inject: 0 into: [ :improvement :key | | difference |
		difference := (caseValues at: key) - (self valueAt: key).
		difference positive ifTrue: [
			self updateKey: key value: (caseValues at: key)
		].
		improvement + (difference max: 0)
	]
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> coverageTable [

	^ coverageTable
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> coverageTable: aCoverageTable [

	coverageTable := aCoverageTable 
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> customMetricsTable [

	^ customMetricsTable
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> customMetricsTable: dict [

	customMetricsTable := dict
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> eval: case [
	
	| improvement caseValues |
	
	caseValues := self values: case.
	improvement := self compareAndUpdateValues: caseValues.
	improvement > 0 ifTrue: [ topCases add: case ].

	^ PBTCaseFeedback from: case improvement: improvement values: caseValues 
	
]

{ #category : 'as yet unclassified' }
PBTFeedbackEvaluator >> feedbackByAllocatedMemory [

	guide := PBTMemoryGuide new evaluator: self
]

{ #category : 'as yet unclassified' }
PBTFeedbackEvaluator >> feedbackByCoverage [

	guide := PBTCoverageGuide new evaluator: self
]

{ #category : 'as yet unclassified' }
PBTFeedbackEvaluator >> feedbackByExecutionTime [

	guide := PBTExecutionTimeGuide new evaluator: self
]

{ #category : 'as yet unclassified' }
PBTFeedbackEvaluator >> feedbackByMethodsCalls [

	guide := PBTMethodsCallsGuide new evaluator: self
]

{ #category : 'as yet unclassified' }
PBTFeedbackEvaluator >> feedbackByScore [

	guide := PBTScoreGuide new evaluator: self
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> initialize [ 

	super initialize.
	
	methodsCalled := Dictionary new.
	memoryTable := Dictionary new.
	coverageTable := Dictionary new.
	performanceTable := Dictionary new.
	customMetricsTable := Dictionary new.
	
	topCases := OrderedCollection new.

	self feedbackByMethodsCalls
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> memoryTable [

	^ memoryTable
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> memoryTable: aMemoryTable [

	memoryTable := aMemoryTable
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> methodsCalled [

	^ methodsCalled
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> methodsCalled: dict [

	methodsCalled := dict
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> performanceTable [

	^ performanceTable
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> performanceTable: aTable [

	performanceTable := aTable
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> topCases [

	^ topCases 
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> updateKey: key value: value [

	guide tableOfValue at: key put: value
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> valueAt: key [

	^ guide tableOfValue at: key ifPresent: [ guide tableOfValue at: key ] ifAbsentPut: [ 0 ]
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> values: case [

	^ (guide values: case) select: [ :value | value > 0 ]
]
