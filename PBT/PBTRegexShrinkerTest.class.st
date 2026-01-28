Class {
	#name : 'PBTRegexShrinkerTest',
	#superclass : 'PBTShrinkerTest',
	#instVars : [
		'shrinker',
		'evaluator'
	],
	#category : 'PBT-Shrinking',
	#package : 'PBT',
	#tag : 'Shrinking'
}

{ #category : 'tests' }
PBTRegexShrinkerTest >> setUp [ 
	
	super setUp.
	self timeLimit: 5 hours.
	shrinker := PBTShrinker new.
	shrinker grammar: GncRegexGrammar new.
	evaluator := PBTEvaluator new profilingByMethodCalls.
	shrinker evaluator: evaluator.
	feedbackEvaluator := PBTFeedbackEvaluator new feedbackByMethodsCalls.
	shrinker feedbackEvaluator: feedbackEvaluator.
	shrinker classesToProfile: ((RxMatcher >> #matches:) package definedClasses).
	shrinker programBlock: [ :input | input asRegex matches: (input minimalStringMatching) ].
]

{ #category : 'tests' }
PBTRegexShrinkerTest >> testShrinkCostlyRegex01 [

	self assert: (shrinker shrink: 'ac?ab?ab|.b?aa.?aaab?c?a(ca)?ac?aaab?a?a') equals: 'cab?ab.?aa?(a)?c?aaab?a?a'.

]

{ #category : 'tests' }
PBTRegexShrinkerTest >> testShrinkCostlyRegex02 [

	self assert: (shrinker shrink: 'ac?ab?ab|.b?aa.?aaab?c?a(ca)?ac?aaab?a?a') equals: 'cab?ab.?aa?(a)?c?aaab?a?a'.

]

{ #category : 'tests' }
PBTRegexShrinkerTest >> testShrinkCostlyRegex03 [

	self assert: (shrinker shrink: 'a+(a+a.?(a*.*a?a*a*b?.*aa?a+|a)+a.a)....a') equals: '((a*.*a?a*a*.*aa)+a.a)....a'.

]
