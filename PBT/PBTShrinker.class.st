Class {
	#name : 'PBTShrinker',
	#superclass : 'Object',
	#instVars : [
		'grammar',
		'evaluator',
		'feedbackEvaluator',
		'threshold',
		'programBlock',
		'classesToProfile'
	],
	#category : 'PBT-Shrinking',
	#package : 'PBT',
	#tag : 'Shrinking'
}

{ #category : 'shrinking' }
PBTShrinker >> candidates: root [
	
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
PBTShrinker >> classesToProfile [

	^ classesToProfile 
]

{ #category : 'testing' }
PBTShrinker >> classesToProfile: someClassesToProfile [

	classesToProfile := someClassesToProfile 
]

{ #category : 'shrinking' }
PBTShrinker >> evalInput: input [

	| profilingResult pbtCase program |
	
	program := PBAProgram from: [ programBlock value: input ] forClasses: classesToProfile.

	profilingResult := evaluator analyzer analyze: program.
	
	pbtCase := PBTTest new result: (PBTEvalSuccess new profilingResult: profilingResult).

	^ feedbackEvaluator eval: pbtCase
]

{ #category : 'accessing' }
PBTShrinker >> evaluator [
	
	^ evaluator
]

{ #category : 'accessing' }
PBTShrinker >> evaluator: anEvaluator [

	evaluator := anEvaluator
]

{ #category : 'shrinking' }
PBTShrinker >> feedbackEvaluator [

	^ feedbackEvaluator 
]

{ #category : 'shrinking' }
PBTShrinker >> feedbackEvaluator: aFeedbackEvaluator [

	feedbackEvaluator := aFeedbackEvaluator 
]

{ #category : 'accessing' }
PBTShrinker >> grammar: aGrammar [

	grammar := aGrammar 
]

{ #category : 'testing' }
PBTShrinker >> initialize [ 
	
	super initialize.
	threshold := 0.9.
	programBlock := nil.
	classesToProfile := nil.
	feedbackEvaluator := nil.
	grammar := nil.
]

{ #category : 'testing' }
PBTShrinker >> isStillValuable: feedback original: originalFeedback [

	^ feedback score >= (originalFeedback score * threshold)
]

{ #category : 'testing' }
PBTShrinker >> isValidTree: node [

	| input derivation |
	input := node asInput.

	[ derivation := self parse: input ] on: Error do: [ ^ false ].
	derivation ifNil: [ ^ false ].

	^ derivation asInput = input
]

{ #category : 'shrinking' }
PBTShrinker >> minimize: node [
	
	| copy |
	copy := self parse: node asInput. "TODO: avoid to copy the node"
	(self candidates: copy) do: [ :child |
		child parent ifNotNil: [ | index |
			index := child parent children indexOf: child. 
			child parent replaceChildAt: index with: child minimumTree
		].
	].

	^ copy
]

{ #category : 'testing' }
PBTShrinker >> parse: input [

	^ PBTGrammarParser parse: input from: grammar
]

{ #category : 'testing' }
PBTShrinker >> programBlock [

	^ programBlock 
]

{ #category : 'testing' }
PBTShrinker >> programBlock: aProgramBlock [

	programBlock := aProgramBlock 
]

{ #category : 'shrinking' }
PBTShrinker >> shrink: input [
	
	| node originalFeedback canImprove |
	
	node := self parse: input.
	node ifNil: [ ^ input ].
	originalFeedback := self evalInput: input.
	
	canImprove := true.
	[ canImprove ] whileTrue: [ | minimized |
		minimized := self minimize: node.
		(minimized asInput = node asInput) ifTrue: [ ^ node asInput ].
		canImprove := (self isValidTree: minimized) and: [ self isStillValuable: (self evalInput: input) original: originalFeedback ].
	
		canImprove ifTrue: [ node := minimized ]
	].

	^ node asInput
]

{ #category : 'testing' }
PBTShrinker >> threshold [

	^ threshold 
]

{ #category : 'testing' }
PBTShrinker >> threshold: aThreshold [

	threshold := aThreshold.
]
