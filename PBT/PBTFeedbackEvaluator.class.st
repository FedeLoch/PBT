Class {
	#name : 'PBTFeedbackEvaluator',
	#superclass : 'Object',
	#instVars : [
		'criteria',
		'better',
		'betterValue',
		'methodsCalled',
		'topCases',
		'guide'
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

	^ value log floor
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> compareAndUpdateValues: caseTable [

	^ caseTable keys inject: false into: [ :isPositive :key | | improves |
		"For the moment the comparision is literal, only if it increments the number is good enough"
		improves := (self improves: caseTable key: key).
		improves ifTrue: [ methodsCalled at: key put: (caseTable at: key) ].
		isPositive or: [ improves ]
	]

	
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> criteria [

	^ criteria 
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> criteria: aBlock [

	criteria := aBlock 
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> eval: case [
	
	| isPositive |
	
	isPositive := self compareAndUpdateValues: (self tableOfValues: case).
	
	isPositive ifTrue: [ topCases add: case ].

	^ PBTFeedback from: case value: isPositive
	
]

{ #category : 'as yet unclassified' }
PBTFeedbackEvaluator >> feedbackByAllocatedMemory [

	guide := PBTMemoryGuide new
]

{ #category : 'as yet unclassified' }
PBTFeedbackEvaluator >> feedbackByCoverage [

	guide := PBTCoverageGuide new
]

{ #category : 'as yet unclassified' }
PBTFeedbackEvaluator >> feedbackByExecutionTime [

	guide := PBTExecutionTimeGuide new
]

{ #category : 'as yet unclassified' }
PBTFeedbackEvaluator >> feedbackByMethodsCalls [

	guide := PBTMethodsCallsGuide new
]

{ #category : 'as yet unclassified' }
PBTFeedbackEvaluator >> feedbackByScore [

	guide := PBTScoreGuide new
]

{ #category : 'as yet unclassified' }
PBTFeedbackEvaluator >> improves: caseTable key: key [

	^ ((methodsCalled includesKey: key) not) or: [ (caseTable at: key) > (methodsCalled at: key) ]
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> initialize [ 

	super initialize.
	methodsCalled := Dictionary new.
	topCases := OrderedCollection new.
	self feedbackByMethodsCalls.
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> methodsCalled: dict [

	methodsCalled := dict
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> methodsCalledFrom: case [

	^ case result profilingResult ifNil: [ Dictionary new ] ifNotNil: [
		case result profilingResult methodsCalled collect: [ :value | self category: value ]
	]
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> tableOfValues: case [

	^ self methodsCalledFrom: case 
]

{ #category : 'accessing' }
PBTFeedbackEvaluator >> topCases [

	^ topCases 
]
