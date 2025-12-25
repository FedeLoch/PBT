Class {
	#name : 'PBTJSONShrinkerTest',
	#superclass : 'TestCase',
	#instVars : [
		'shrinker',
		'evaluator',
		'feedbackEvaluator'
	],
	#category : 'PBT-Shrinking',
	#package : 'PBT',
	#tag : 'Shrinking'
}

{ #category : 'tests' }
PBTJSONShrinkerTest >> setUp [ 
	
	super setUp.
	self timeLimit: 5 hours.
	shrinker := PBTShrinker new.
	shrinker grammar: JSONGrammar new.
	evaluator := PBTEvaluator new profilingByMethodCalls.
	shrinker evaluator: evaluator.
	feedbackEvaluator := PBTFeedbackEvaluator new feedbackByMethodsCalls.
	shrinker feedbackEvaluator: feedbackEvaluator.
	shrinker classesToProfile: ((NeoJSONReader class >> #fromString:) package definedClasses).
	shrinker programBlock: [ :input | NeoJSONReader fromString: input ].
]

{ #category : 'tests' }
PBTJSONShrinkerTest >> testShrinkNestedArraysToNormalForm [

	| guidingFeedback |

	guidingFeedback := shrinker evalInput: '[[[[]],[3,4]],[[5,6],[7,8]]]'.
	self updateFeedbackEvaluatorWith: guidingFeedback values.
	
	self assert: (shrinker shrink: '[[[[]]],{"a":null}]') equals: '[]'.

]

{ #category : 'tests' }
PBTJSONShrinkerTest >> updateFeedbackEvaluatorWith: feedback [

	feedbackEvaluator guide setBase: feedback.

]
