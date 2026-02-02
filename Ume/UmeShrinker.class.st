Class {
	#name : 'UmeShrinker',
	#superclass : 'Object',
	#instVars : [
		'grammar',
		'evaluator',
		'feedbackEvaluator',
		'threshold',
		'programBlock',
		'classesToProfile',
		'memo'
	],
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'shrinking' }
UmeShrinker >> candidates: root [
	
	| worstReward worst |
	worstReward := SmallInteger maxVal.
	worst := OrderedCollection new.
	
	root allNodes do: [ :node | | reward |
		reward := node reward: grammar root: root.
		(reward < worstReward) ifTrue: [ worstReward := reward . worst := OrderedCollection new ].
		(reward = worstReward) ifTrue: [ worst add: node ]
	].

	^ worst.

]

{ #category : 'testing' }
UmeShrinker >> classesToProfile [

	^ classesToProfile 
]

{ #category : 'testing' }
UmeShrinker >> classesToProfile: someClassesToProfile [

	classesToProfile := someClassesToProfile 
]

{ #category : 'shrinking' }
UmeShrinker >> evalInput: input [

	| profilingResult pbtCase program |
	
	(input = 'aa*a*..') ifTrue: [ 1 halt. ].
	
	memo at: input ifAbsentPut: [
		program := PBAProgram from: [ programBlock value: input ] forClasses: classesToProfile.

		[ 	profilingResult := evaluator analyzer analyze: program.
			pbtCase := UmeTest new result: (UmeEvalSuccess new profilingResult: profilingResult)
		] on: Error do: [ ^ nil ].

		(feedbackEvaluator eval: pbtCase) absoluteImprovement
	].
	
	^ memo at: input
]

{ #category : 'accessing' }
UmeShrinker >> evaluator [
	
	^ evaluator
]

{ #category : 'accessing' }
UmeShrinker >> evaluator: anEvaluator [

	evaluator := anEvaluator
]

{ #category : 'shrinking' }
UmeShrinker >> feedbackEvaluator [

	^ feedbackEvaluator 
]

{ #category : 'shrinking' }
UmeShrinker >> feedbackEvaluator: aFeedbackEvaluator [

	feedbackEvaluator := aFeedbackEvaluator 
]

{ #category : 'accessing' }
UmeShrinker >> grammar: aGrammar [

	grammar := aGrammar 
]

{ #category : 'testing' }
UmeShrinker >> initialize [ 
	
	super initialize.
	threshold := 0.95.
	programBlock := nil.
	classesToProfile := nil.
	feedbackEvaluator := nil.
	memo := Dictionary new.
	grammar := nil.
]

{ #category : 'testing' }
UmeShrinker >> isStillValuable: score original: originalScore [

	score ifNil: [ ^ false ].

	^ score >= (originalScore * threshold)
]

{ #category : 'testing' }
UmeShrinker >> isValidTree: node [

	| input derivation |
	input := node asInput.

	[ derivation := self parse: input ] on: Error do: [ ^ false ].
	derivation ifNil: [ ^ false ].

	^ derivation asInput = input
]

{ #category : 'shrinking' }
UmeShrinker >> minimize: node upperBound: bound [
	
	(self candidates: node) do: [ :child | | parent |
		parent := child parent.
		parent ifNotNil: [ | index |
			"TODO: add a memoization to know if the child is removable or not"
			index := parent children indexOf: child.
			parent replaceChildAt: index with: child emptyTree.

			((self isValidTree: node) and: [ self isStillValuable: (self evalInput: node asInput) original: bound ]) ifFalse: [
				parent replaceChildAt: index with: child.
			]
		].
	].

	^ node
]

{ #category : 'testing' }
UmeShrinker >> parse: input [

	^ UmeGrammarParser parse: input from: grammar
]

{ #category : 'testing' }
UmeShrinker >> programBlock [

	^ programBlock 
]

{ #category : 'testing' }
UmeShrinker >> programBlock: aProgramBlock [

	programBlock := aProgramBlock 
]

{ #category : 'shrinking' }
UmeShrinker >> shrink: input [
	
	| node minimizedNode feedback currentInput prevValidInput |
	
	prevValidInput := input.
	currentInput := input.

	(self parse: input) ifNil: [ ^ input ].
	feedback := self evalInput: input.
		
	[ true ] whileTrue: [
		node := self parse: currentInput.

		minimizedNode := self minimize: node upperBound: feedback.
		(minimizedNode asInput = currentInput) ifTrue: [ ^ currentInput ].
		self evalInput: minimizedNode.

		prevValidInput := currentInput.
		currentInput := minimizedNode asInput.
	]
]

{ #category : 'testing' }
UmeShrinker >> threshold [

	^ threshold 
]

{ #category : 'testing' }
UmeShrinker >> threshold: aThreshold [

	threshold := aThreshold.
]
