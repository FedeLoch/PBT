Class {
	#name : 'UmeShrinkerTest',
	#superclass : 'TestCase',
	#instVars : [
		'feedbackEvaluator'
	],
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'tests' }
UmeShrinkerTest >> updateFeedbackEvaluatorWith: feedback [

	feedbackEvaluator guide setBase: feedback.

]
