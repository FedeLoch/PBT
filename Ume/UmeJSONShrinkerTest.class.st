Class {
	#name : 'UmeJSONShrinkerTest',
	#superclass : 'UmeShrinkerTest',
	#instVars : [
		'shrinker',
		'evaluator'
	],
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'tests' }
UmeJSONShrinkerTest >> setUp [ 
	
	super setUp.
	self timeLimit: 5 hours.
	shrinker := UmeShrinker new.
	shrinker grammar: JSONGrammar new.
	evaluator := UmeEvaluator new profilingByMethodCalls.
	shrinker evaluator: evaluator.
	feedbackEvaluator := UmeFeedbackEvaluator new feedbackByMethodsCalls.
	shrinker feedbackEvaluator: feedbackEvaluator.
	shrinker classesToProfile: ((NeoJSONReader class >> #fromString:) package definedClasses).
	shrinker programBlock: [ :input | NeoJSONReader fromString: input ].
]

{ #category : 'tests' }
UmeJSONShrinkerTest >> testShrinkNestedArraysToNormalForm [

	self assert: (shrinker shrink: '[[[[1,2,3]]],{"a":null}]') equals: '[[[[1,3]]],{}]'.

]

{ #category : 'tests' }
UmeJSONShrinkerTest >> testShrinkNestedArraysToNormalForm2 [
 
	| input |
	
	input := '[[[[[[[[[[[[[[[[44,22],"u",[8],3,7],9,1],5,9],6,7],8,8],6,3],9,3],8,9],9,8],3,5],1,8],6,2],5,18],2,5],8,3]'.
	
	self assert: (shrinker shrink: input) equals: '[[[[[[[[[[[[[],6],8],6],9,3],8,9],9,8],3,5],1,8],6,2],5,8],2,5],8,3]'.

]
