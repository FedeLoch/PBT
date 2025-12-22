Class {
	#name : 'PBTShrinker',
	#superclass : 'Object',
	#instVars : [
		'grammar',
		'evaluator'
	],
	#category : 'PBT-Shrinking',
	#package : 'PBT',
	#tag : 'Shrinking'
}

{ #category : 'instance creation' }
PBTShrinker class >> from: aGrammar runner: aRunner [

	^ self new
		grammar: aGrammar;
		runner: aRunner;
		yourself
]

{ #category : 'accessing' }
PBTShrinker >> evaluator [
	
	^ evaluator ifNil: [ evaluator := runner evaluator ]
]

{ #category : 'accessing' }
PBTShrinker >> grammar: aGrammar [

	grammar := aGrammar 
]

{ #category : 'testing' }
PBTShrinker >> isStillBad: newResult original: originalResult [

	"Check if the new result is comparable to the original result (e.g., within 90% of execution time)"
	"For now, we just check if it has a score or if execution time is significant"
	
	^ newResult score > (originalResult score * 0.9)
]

{ #category : 'testing' }
PBTShrinker >> isValidStructure: anAST [

	"Check if the AST respects basic grammar constraints (if necessary)"
	^ true
]

{ #category : 'accessing' }
PBTShrinker >> runner: aRunner [

	runner := aRunner
]

{ #category : 'shrinking' }
PBTShrinker >> shrink: input [
	
	| ast bestInput bestFeedback |
	
	"Parse initial input"
	ast := PBTGrammarParser parse: input from: grammar.
	ast ifNil: [ ^ input ].
	bestInput := input.
	bestFeedback := evaluator eval: input.

	"Iterate over nodes (bottom-up might be better, or just allNodes)"
	ast allNodes do: [ :node | 
		node children do: [ :child |
			"Check if child can replace node (same type/grammar rule)"
			(child canReplace: node) ifTrue: [
				| originalParent originalIndex newInput newFeedback |
				
				originalParent := node parent.
				originalIndex := originalParent indexOf: node.
				
				"Apply Mutation"
				originalParent replaceChildAt: originalIndex with: child.
				newInput := ast asStringInput.
				
				"Evaluate"
				newFeedback := evaluator eval: newInput.
				
				(self isStillBad: newFeedback original: bestFeedback) 
					ifTrue: [ 
						bestInput := newInput.
						bestFeedback := newFeedback. 
					] "Keep change"
					ifFalse: [ 
						"Revert change"
						originalParent replaceChildAt: originalIndex with: node.
					]
			]
		]
	].

	^ bestInput
]


