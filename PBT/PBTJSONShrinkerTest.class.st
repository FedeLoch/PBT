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

	| input guidingInput shrunk guidingFeedback |

	guidingInput := '[[[1,2],[3,4]],[[5,6],[7,8]]]'.
	
	guidingFeedback := shrinker evalInput: guidingInput.
	self updateFeedbackEvaluatorWith: guidingFeedback values.
	
	input := '[[{}, 2],{"a":null}]'.
	shrunk := shrinker shrink: input.
	
	self assert: shrunk equals: '[]'.

]

{ #category : 'tests' }
PBTJSONShrinkerTest >> updateFeedbackEvaluatorWith: feedback [

	feedbackEvaluator guide setBase: feedback.

]
