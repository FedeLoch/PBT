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
PBTRegexShrinkerTest >> testShrinkCostlyRegex [

	self assert: (shrinker shrink: 'aa*a*..*.+(.+.?(.?.*((.b.b.aab)a|)a*))+a') equals: 'aa*a*..'.

]
