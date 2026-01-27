Class {
	#name : 'PBTShrinkerTest',
	#superclass : 'TestCase',
	#instVars : [
		'feedbackEvaluator'
	],
	#category : 'PBT-Shrinking',
	#package : 'PBT',
	#tag : 'Shrinking'
}

{ #category : 'tests' }
PBTShrinkerTest >> updateFeedbackEvaluatorWith: feedback [

	feedbackEvaluator guide setBase: feedback.

]
