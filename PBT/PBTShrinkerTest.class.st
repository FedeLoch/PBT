Class {
	#name : 'PBTShrinkerTest',
	#superclass : 'TestCase',
	#category : 'PBT-Shrinking',
	#package : 'PBT',
	#tag : 'Shrinking'
}



{ #category : 'tests' }
PBTShrinkerTest >> testShrinkNestedArrays [

	| shrinker input shrunk mockEvaluator |
	
	"Nested array of arrays of arrays"
	input := '[[[1,2],[3,4]],[[5,6],[7,8]]]'.
	
	"Create a mock evaluator using a block or a simple object"
	mockEvaluator := Object new.
	mockEvaluator class compile: 'eval: input 
		| depth |
		depth := input occurrencesOf: $[.
		"Return a feedback object with score. Assuming PBTFeedback or similar structure."
		"For this test, we can use PBTTest as a dummy feedback container if score is sufficient."
		^ PBTTest new score: (depth > 2 ifTrue: [ 100 ] ifFalse: [ 10 ]); yourself'.
	
	shrinker := PBTShrinker new.
	shrinker grammar: JSONGrammar new.
	shrinker evaluator: mockEvaluator.
	
	shrunk := shrinker shrink: input.
	
	"The shrinker should reduce the input but keep the depth > 2 condition if possible"
	"The minimal input with depth > 2 is '[[[]]]' or similar depending on grammar constraints"
	
	"For JSON grammar: [[[1]]] or similar"
	
	self assert: shrunk size < input size.
	self assert: (shrunk occurrencesOf: $[) > 2. "Should maintain the 'bad' property"
]
