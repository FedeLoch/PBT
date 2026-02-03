Class {
	#name : 'UmeExecutionTimeGuide',
	#superclass : 'UmeFeedbackGuide',
	#category : 'Ume-Feedback',
	#package : 'Ume',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
UmeExecutionTimeGuide >> tableOfValue [

	^ evaluator performanceTable
]

{ #category : 'accessing' }
UmeExecutionTimeGuide >> values: case [

	^ case result profilingResult ifNil: [ Dictionary new ] ifNotNil: [ {
		'executionTime' -> (evaluator category: case result profilingResult executionTime)
	} asDictionary ]
]
