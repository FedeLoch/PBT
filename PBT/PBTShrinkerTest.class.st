Class {
	#name : 'PBTShrinkerTest',
	#superclass : 'TestCase',
	#category : 'PBT-Shrinking',
	#package : 'PBT',
	#tag : 'Shrinking'
}

{ #category : 'tests' }
{ #category : 'tests' }
PBTShrinkerTest >> testShrinkNestedArraysToNormalForm [

	| shrinker input shrunk evaluator feedbackEvaluator |

	input := '[[[1,2],[3,4]],[[5,6],[7,8]]]'.
	
	evaluator := PBTMockEvaluator new.
	feedbackEvaluator := PBTFeedbackEvaluator new.
	feedbackEvaluator feedbackByExecutionTime. 
	
	shrinker := PBTShrinker new.
	shrinker grammar: JSONGrammar new.
	shrinker evaluator: evaluator.
	shrinker feedbackEvaluator: feedbackEvaluator.
	
	shrunk := shrinker shrink: input.
	
	self assert: shrunk size < input size.
	self assert: (shrunk occurrencesOf: $[) > 2.

	self deny: (shrunk includes: $1).
	self deny: (shrunk includes: $2).
]
