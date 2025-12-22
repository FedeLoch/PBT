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
	
	| ast bestInput bestFeedback candidates |
	
	ast := self parse: input.
	ast ifNil: [ ^ input ].
	
	bestInput := input.
	bestFeedback := self evalInput: input.
	
	"Collect all valid shrink candidates: { parent. index. child }"
	candidates := OrderedCollection new.
	ast allNodes do: [ :node | 
		node children do: [ :child |
			(child canReplace: node) ifTrue: [
				candidates add: { node parent. node parent indexOf: node. child }
			]
		]
	].

	"Sort by Child Weight DESCENDING (Prioritize keeping Heavy nodes)"
	candidates sort: [ :a :b | a third weight > b third weight ].

	"Apply Shrinks"
	candidates do: [ :cand |
		| parent index child newInput newFeedback |
		parent := cand first.
		index := cand second.
		child := cand third.

		"Check if parent still has the child at that index (structure preservation check)"
		((parent children size >= index) and: [ (parent children at: index) grammarRule = child grammarRule ]) ifTrue: [ 

			| originalNode |
			originalNode := parent children at: index.
			
			"Apply Mutation"
			parent replaceChildAt: index with: child.
			newInput := ast asStringInput.
			
			newFeedback := self evalInput: newInput.
			
			(self isStillValuable: newFeedback original: bestFeedback) 
				ifTrue: [  
					bestInput := newInput. 
					bestFeedback := newFeedback.
				]
				ifFalse: [ 
					"Revert"
					parent replaceChildAt: index with: originalNode 
				]
		]
	].

	^ bestInput
]
