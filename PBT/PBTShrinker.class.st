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
PBTShrinker >> minimize: node originalFeedback: originalFeedback [
	
	| copy canImprove |
	copy := self parse: node asInput.
	
	"Try the primitive minimize (replace with minimumTree)"
	(self candidates: copy) do: [ :child |
		child parent ifNotNil: [ | index |
			index := child parent children indexOf: child. 
			child parent replaceChildAt: index with: child minimumTree
		].
	].

	"Try divide and conquer on children of the root and recursively"
	self shrinkChildrenOf: copy original: originalFeedback.

	^ copy
]

{ #category : 'shrinking' }
PBTShrinker >> shrink: input [
	
	| node originalFeedback canImprove |
	node := self parse: input.
	node ifNil: [ ^ input ].
	originalFeedback := self evalInput: input.
	
	canImprove := true.
	[ canImprove ] whileTrue: [ | minimized minimizedInput minimizedFeedback |
		minimized := self minimize: node originalFeedback: originalFeedback.
		minimizedInput := minimized asInput.
		(minimizedInput = node asInput) ifTrue: [ ^ node asInput ].
		
		minimizedFeedback := self evalInput: minimizedInput.
		canImprove := (self isValidTree: minimized) and: [ self isStillValuable: minimizedFeedback original: originalFeedback ].
	
		canImprove ifTrue: [ node := minimized ]
	].

	^ node asInput
]

{ #category : 'shrinking' }
PBTShrinker >> shrinkChildren: children range: range of: node original: originalFeedback [
	
	| start end mid |
	start := range first.
	end := range last.
	(start > end) ifTrue: [ ^ self ].

	"Try removing this chunk"
	(self tryRemovingChildrenFrom: start to: end in: node original: originalFeedback)
		ifTrue: [ ^ self ]. "Success! This chunk is gone, no need to recurse inside it"

	"If couldn't remove the whole chunk and there's more than one element, split"
	(start < end) ifTrue: [
		mid := start + (end - start // 2).
		self shrinkChildren: node children range: (start to: mid) of: node original: originalFeedback.
		self shrinkChildren: node children range: (mid + 1 to: end) of: node original: originalFeedback.
	].

	"Finally, recurse into children themselves if they weren't removed"
	(start to: (end min: node children size)) do: [ :i |
		self shrinkChildrenOf: (node children at: i) original: originalFeedback
	].
]

{ #category : 'shrinking' }
PBTShrinker >> shrinkChildrenOf: node original: originalFeedback [
	
	node isLeaf ifTrue: [ ^ self ].
	
	self shrinkChildren: node children range: (1 to: node children size) of: node original: originalFeedback.
]

{ #category : 'shrinking' }
PBTShrinker >> tryRemovingChildrenFrom: start to: end in: node original: originalFeedback [
	
	| originalChildren newChildren result |
	originalChildren := node children copy.
	newChildren := OrderedCollection new.
	(1 to: start - 1) do: [ :i | newChildren add: (originalChildren at: i) ].
	(end + 1 to: originalChildren size) do: [ :i | newChildren add: (originalChildren at: i) ].
	
	node children: newChildren.
	
	"Validate"
	result := (self isValidTree: node root) and: [ self isStillValuable: (self evalInput: node root asInput) original: originalFeedback ].
	
	result ifFalse: [ node children: originalChildren ].
	
	^ result
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

{ #category : 'testing' }
PBTShrinker >> threshold [

	^ threshold 
]

{ #category : 'testing' }
PBTShrinker >> threshold: aThreshold [

	threshold := aThreshold.
]
