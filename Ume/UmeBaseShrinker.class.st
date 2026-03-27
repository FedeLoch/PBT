Class {
	#name : 'UmeBaseShrinker',
	#superclass : 'Object',
	#instVars : [
		'grammar',
		'evaluator',
		'feedbackEvaluator',
		'threshold',
		'programBlock',
		'classesToProfile',
		'memo',
		'maxIterations'
	],
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'configuration' }
UmeBaseShrinker >> classesToProfile [

	^ classesToProfile 
]

{ #category : 'configuration' }
UmeBaseShrinker >> classesToProfile: someClassesToProfile [

	classesToProfile := someClassesToProfile 
]

{ #category : 'shrinking' }
UmeBaseShrinker >> evalInput: input [

	memo at: input ifAbsentPut: [
		| profilingResult umeCase program |
		program := PBAProgram from: [ programBlock value: input ] forClasses: classesToProfile.

		[ profilingResult := evaluator analyzer analyze: program.
			umeCase := UmeTest new result: (UmeEvalSuccess new profilingResult: profilingResult)
		] on: Error do: [ ^ nil ].

		(feedbackEvaluator eval: umeCase) absoluteImprovement
	].
	
	^ memo at: input
]

{ #category : 'accessing' }
UmeBaseShrinker >> evaluator [
	^ evaluator
]

{ #category : 'configuration' }
UmeBaseShrinker >> evaluator: anEvaluator [
	evaluator := anEvaluator
]

{ #category : 'shrinking' }
UmeBaseShrinker >> feedbackEvaluator [
	^ feedbackEvaluator 
]

{ #category : 'configuration' }
UmeBaseShrinker >> feedbackEvaluator: aFeedbackEvaluator [
	feedbackEvaluator := aFeedbackEvaluator 
]

{ #category : 'accessing' }
UmeBaseShrinker >> grammar [
	^ grammar
]

{ #category : 'configuration' }
UmeBaseShrinker >> grammar: aGrammar [
	grammar := aGrammar 
]

{ #category : 'configuration' }
UmeBaseShrinker >> initialize [ 
	super initialize.
	threshold := 0.95.
	maxIterations := 1000.
	programBlock := nil.
	classesToProfile := nil.
	feedbackEvaluator := nil.
	memo := Dictionary new.
	grammar := nil
]

{ #category : 'testing' }
UmeBaseShrinker >> isStillValuable: score original: originalScore [
	score ifNil: [ ^ false ].
	^ score >= (originalScore * threshold)
]

{ #category : 'configuration' }
UmeBaseShrinker >> maxIterations [
	^ maxIterations
]

{ #category : 'configuration' }
UmeBaseShrinker >> maxIterations: anInteger [
	maxIterations := anInteger
]

{ #category : 'parsing' }
UmeBaseShrinker >> parse: input [
	^ UmeGrammarParser parse: input from: grammar
]

{ #category : 'configuration' }
UmeBaseShrinker >> programBlock [
	^ programBlock 
]

{ #category : 'configuration' }
UmeBaseShrinker >> programBlock: aProgramBlock [
	programBlock := aProgramBlock 
]

{ #category : 'shrinking' }
UmeBaseShrinker >> resetMemoization [
	memo := Dictionary new
]

{ #category : 'shrinking' }
UmeBaseShrinker >> shrink: input [
	self subclassResponsibility 
]

{ #category : 'configuration' }
UmeBaseShrinker >> threshold [
	^ threshold 
]

{ #category : 'configuration' }
UmeBaseShrinker >> threshold: aThreshold [
	threshold := aThreshold
]
