Class {
	#name : 'PBTShrinkerTest',
	#superclass : 'TestCase',
	#instVars : [
		'feedbackEvaluator'
	],
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'tests' }
PBTShrinkerTest >> updateFeedbackEvaluatorWith: feedback [

	feedbackEvaluator guide setBase: feedback.

]
