Class {
	#name : 'PBTShrinker',
	#superclass : 'Object',
	#instVars : [
		'grammar',
		'evaluator',
		'feedbackEvaluator'
	],
	#category : 'PBT-Shrinking',
	#package : 'PBT',
	#tag : 'Shrinking'
}

{ #category : 'shrinking' }
PBTShrinker >> evalInput: input [

	| profilingResult pbtCase |
	profilingResult := evaluator analyzer analyze: input.
	
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
PBTShrinker >> isStillValuable: feedback original: originalFeedback [

	| threshold |
	
	threshold := 0.9.

	^ feedback score >= (originalFeedback score * threshold)
]

{ #category : 'testing' }
PBTShrinker >> isValidTree: ast [

	| input derivation |
	input := ast asStringInput.

	[ derivation := self parse: input ] on: Error do: [ ^ false ].
	derivation ifNil: [ ^ false ].

	^ derivation asStringInput = input
]

{ #category : 'testing' }
PBTShrinker >> parse: input [

	^ PBTGrammarParser parse: input from: grammar
]

{ #category : 'shrinking' }
PBTShrinker >> shrink: input [
	
	| ast bestInput bestFeedback |
	
	ast := self parse: input.
	ast ifNil: [ ^ input ].
	
	bestInput := input.
	bestFeedback := self evalInput: input.

	ast allNodes do: [ :node | 
		node children do: [ :child |
			(child canReplace: node) ifTrue: [

				| originalParent originalIndex newInput newFeedback |
				
				originalParent := node parent.
				originalIndex := originalParent indexOf: node.
				
				"Apply Mutation"
				originalParent replaceChildAt: originalIndex with: child.
				newInput := ast asStringInput.
				
				newFeedback := self evalInput: input.
				
				(self isStillValuable: newFeedback original: bestFeedback) 
					ifTrue: [  bestInput := newInput. bestFeedback := newFeedback ]
					ifFalse: [ originalParent replaceChildAt: originalIndex with: node ]
			]
		]
	].

	^ bestInput
]
