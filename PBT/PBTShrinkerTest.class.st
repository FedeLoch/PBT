Class {
	#name : 'PBTShrinkerTest',
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
PBTShrinkerTest >> setUp [ 

	super setUp.
	shrinker := PBTShrinker new.
	shrinker grammar: JSONGrammar new.
	shrinker evaluator: evaluator.
	shrinker feedbackEvaluator: feedbackEvaluator.
]

{ #category : 'tests' }
PBTShrinkerTest >> testShrinkNestedArraysToNormalForm [

	| input shrunk |

	input := '[[[1,2],[3,4]],[[5,6],[7,8]]]'.
	
	shrunk := shrinker shrink: input.
	
	self assert: shrunk equals: '[]'.

]
