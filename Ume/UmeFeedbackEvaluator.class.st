Class {
	#name : 'UmeFeedbackEvaluator',
	#superclass : 'Object',
	#instVars : [
		'methodsCalled',
		'topCases',
		'guide',
		'memoryTable',
		'coverageTable',
		'performanceTable',
		'customMetricsTable',
		'bytecodesTable'
	],
	#category : 'Ume-Feedback',
	#package : 'Ume',
	#tag : 'Feedback'
}

{ #category : 'instance creation' }
UmeFeedbackEvaluator class >> from: aBlock [

	^ self new criteria: aBlock 
]

{ #category : 'ston-core' }
UmeFeedbackEvaluator class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( criteria )
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> bytecodesTable [

	^ bytecodesTable
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> bytecodesTable: aBytecodesTable [

	bytecodesTable := aBytecodesTable
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> category: value [
	
	value == 0 ifTrue: [ ^ 0 ].

	^ value ln rounded
]

{ #category : 'as yet unclassified' }
UmeFeedbackEvaluator >> clear [

	topCases := OrderedCollection new
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> compareAndUpdateValues: caseValues [

	^ caseValues keys inject: 0 into: [ :improvement :key | | difference |
		difference := (caseValues at: key) - (self valueAt: key).
		difference positive ifTrue: [
			self updateKey: key value: (caseValues at: key)
		].
	
		improvement + (difference > 0 ifTrue: [ caseValues at: key ] ifFalse: [ 0 ])
	]
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> coverageTable [

	^ coverageTable
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> coverageTable: aCoverageTable [

	coverageTable := aCoverageTable 
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> customMetricsTable [

	^ customMetricsTable
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> customMetricsTable: dict [

	customMetricsTable := dict
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> eval: case [
	
	| improvement caseValues |

	caseValues := self values: case.
	improvement := self compareAndUpdateValues: caseValues.
	improvement > 0 ifTrue: [ topCases add: case ].

	^ UmeCaseFeedback from: case improvement: improvement values: caseValues 
	
]

{ #category : 'as yet unclassified' }
UmeFeedbackEvaluator >> feedbackByAllocatedMemory [

	guide := UmeMemoryGuide new evaluator: self
]

{ #category : 'as yet unclassified' }
UmeFeedbackEvaluator >> feedbackByBytecodes [

	guide := UmeBytecodesGuide new evaluator: self
]

{ #category : 'as yet unclassified' }
UmeFeedbackEvaluator >> feedbackByCoverage [

	guide := UmeCoverageGuide new evaluator: self
]

{ #category : 'as yet unclassified' }
UmeFeedbackEvaluator >> feedbackByExecutionTime [

	guide := UmeExecutionTimeGuide new evaluator: self
]

{ #category : 'as yet unclassified' }
UmeFeedbackEvaluator >> feedbackByMethodsCalls [

	guide := UmeMethodsCallsGuide new evaluator: self
]

{ #category : 'as yet unclassified' }
UmeFeedbackEvaluator >> feedbackByScore [

	guide := UmeScoreGuide new evaluator: self
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> guide [

	^ guide
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> initialize [ 

	super initialize.
	
	methodsCalled := Dictionary new.
	memoryTable := Dictionary new.
	coverageTable := Dictionary new.
	performanceTable := Dictionary new.
	customMetricsTable := Dictionary new.
	bytecodesTable := Dictionary new.
	
	topCases := OrderedCollection new.

	self feedbackByMethodsCalls
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> memoryTable [

	^ memoryTable
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> memoryTable: aMemoryTable [

	memoryTable := aMemoryTable
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> methodsCalled [

	^ methodsCalled
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> methodsCalled: dict [

	methodsCalled := dict
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> performanceTable [

	^ performanceTable
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> performanceTable: aTable [

	performanceTable := aTable
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> topCases [

	^ topCases 
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> updateKey: key value: value [

	guide tableOfValue at: key put: value
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> valueAt: key [

	^ guide tableOfValue at: key ifPresent: [ guide tableOfValue at: key ] ifAbsentPut: [ 0 ]
]

{ #category : 'accessing' }
UmeFeedbackEvaluator >> values: case [

	^ guide values: case
]
