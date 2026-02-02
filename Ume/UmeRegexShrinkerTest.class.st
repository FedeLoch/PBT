Class {
	#name : 'UmeRegexShrinkerTest',
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
UmeRegexShrinkerTest >> setUp [ 
	
	super setUp.
	self timeLimit: 5 hours.
	shrinker := UmeShrinker new.
	shrinker grammar: GncRegexGrammar new.
	evaluator := UmeEvaluator new profilingByMethodCalls.
	shrinker evaluator: evaluator.
	feedbackEvaluator := UmeFeedbackEvaluator new feedbackByMethodsCalls.
	shrinker feedbackEvaluator: feedbackEvaluator.
	shrinker classesToProfile: ((RxMatcher >> #matches:) package definedClasses).
	shrinker programBlock: [ :input | input asRegex matches: (input minimalStringMatching) ].
]

{ #category : 'tests' }
UmeRegexShrinkerTest >> testShrinkCostlyRegex01 [

	self assert: (shrinker shrink: 'ac?ab?ab|.b?aa.?aaab?c?a(ca)?ac?aaab?a?a') equals: 'cab?ab.?aa?(a)?c?aaab?a?a'.

]

{ #category : 'tests' }
UmeRegexShrinkerTest >> testShrinkCostlyRegex02 [

	self assert: (shrinker shrink: 'ac?ab?ab|.b?aa.?aaab?c?a(ca)?ac?aaab?a?a') equals: 'cab?ab.?aa?(a)?c?aaab?a?a'.

]

{ #category : 'tests' }
UmeRegexShrinkerTest >> testShrinkCostlyRegex03 [

	self assert: (shrinker shrink: 'a+(a+a.?(a*.*a?a*a*b?.*aa?a+|a)+a.a)....a') equals: '((a*.*a?a*a*.*aa)+a.a)....a'.

]
