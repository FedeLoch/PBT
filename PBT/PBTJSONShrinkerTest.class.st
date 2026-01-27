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

	self updateFeedbackEvaluatorWith: (shrinker evalInput: '[[[[]],[3,4]],[[5,6],[7,8]]]') values.
	
	self assert: (shrinker shrink: '[[[[1,2,3]]],{"a":null}]') equals: '[[[[1,3]]],{}]'.

]

{ #category : 'tests' }
PBTJSONShrinkerTest >> testShrinkNestedArraysToNormalForm2 [

	| input |
	
	input := '[[[[[[[[[[[[[[[[44,22],"u",[8],3,7],9,1],5,9],6,7],8,8],6,3],9,3],8,9],9,8],3,5],1,8],6,2],5,18],2,5],8,3]'.
	self updateFeedbackEvaluatorWith: (shrinker evalInput: input) values.
	
	self assert: (shrinker shrink:  input) equals: '[[[[[[[[[[[[[],6],8],6],9,3],8,9],9,8],3,5],1,8],6,2],5,8],2,5],8,3]'.

]

{ #category : 'tests' }
PBTJSONShrinkerTest >> updateFeedbackEvaluatorWith: feedback [

	feedbackEvaluator guide setBase: feedback.

]
