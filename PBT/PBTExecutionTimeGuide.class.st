Class {
	#name : 'PBTExecutionTimeGuide',
	#superclass : 'PBTFeedbackGuide',
	#category : 'PBT-Feedback',
	#package : 'PBT',
	#tag : 'Feedback'
}

{ #category : 'as yet unclassified' }
PBTExecutionTimeGuide >> tableOfValue [

	^ evaluator performanceTable
]

{ #category : 'accessing' }
PBTExecutionTimeGuide >> values: case [

	^ case result profilingResult ifNil: [ Dictionary new ] ifNotNil: [ {
		'executionTime' -> (evaluator category: case result profilingResult executionTime)
	} asDictionary ]
]
