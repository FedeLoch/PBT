Class {
	#name : 'PBTTreeGrammarMutator',
	#superclass : 'PBTStringMutator',
	#instVars : [
		'maxInputSize',
		'grammar',
		'generator'
	],
	#category : 'PBT-Mutators',
	#package : 'PBT',
	#tag : 'Mutators'
}

{ #category : 'instance creation' }
PBTTreeGrammarMutator class >> from: aGrammar [

	^ self new gammar: aGrammar
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> applyMutation: string [

	^ (self mutateAST: (self tree: string)) asStringInput
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> feed: feedback [

	feedback ifNotNil: [ | ast amount |
		[ ast := self tree: (feedback case) ] on: Error do: [ ^ nil ].
		"We feed the grammar by doing backPropagation with the grammar"
		amount := (feedback isPositive) ifTrue: [ feedback improvement ] ifFalse: [ -1 ].
		ast backPropagateToChildren: feedback improvement level: 0.
	]
]

{ #category : 'as yet unclassified' }
PBTTreeGrammarMutator >> gammar: aGrammar [
	
	grammar := aGrammar
]

{ #category : 'initialization' }
PBTTreeGrammarMutator >> initialize [

	super initialize.
	maxInputSize := SmallInteger maxVal.
	generator := GrammarMCTSGenerator new
		             maxHeight: 20;
		             totalGenerations: 1;
		             explorationConstant: 1.41
]

{ #category : 'testing' }
PBTTreeGrammarMutator >> isReplace: string [

	^ string size >= maxInputSize
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> maxInputSize: anInteger [

	maxInputSize := anInteger.
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> minimumNodeRewarded: root [

	| worst worstReward | 
	worstReward := SmallInteger maxVal.
	worst := OrderedCollection new.
	
	root allNodes do: [ :node | | reward |
		reward := node reward: grammar root: root.
		(reward < worstReward) ifTrue: [ worstReward := reward . worst := OrderedCollection new ].
		(reward = worstReward) ifTrue: [ worst add: node ]
	].

	"We return a random node from the collection of worst ones"
	^ worst atRandom. 
	
"	^ (root allNodes sort: [ :node1 :node2 |
		(node1 reward: grammar root: root) > (node2 reward: grammar root: root)
	]) last"
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> mutateAST: ast [
	
	| aNode node parentSize newChildren |

	aNode := self pickNode: ast.
	node := aNode isLeaf ifTrue: [ aNode parent ] ifFalse: [ aNode ].

	parentSize := ast generate size - (node generate size).

	newChildren := (self subNodesFrom: node grammarRule parentSize: parentSize level: (ast treeHeight - node treeHeight)).
	
	node children: newChildren.
	
	^ ast	
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> pickNode: ast [

"	| selected |

	selected := ast at: ((2 to: ast treeSize) atRandom)."
	
	"10 % of selecting a random node"
	((1 to: 100) atRandom) <= 10 ifTrue: [ ^ ast at: ((2 to: ast treeSize) atRandom) ].

	"Select a random leaf"
	^ self minimumNodeRewarded: ast
	"ast aLeaf"
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> subNodeFrom: grammarNode parentSize: parentSize level: level [

	| maxSize |

	maxSize := maxInputSize - parentSize.
	generator maxSize: maxSize + 1; totalGenerations: generator totalGenerations + 1.

	^ grammarNode generateMCTSAst: generator level: level.
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> subNodesFrom: grammarRule parentSize: parentSize level: level [

	| currentSize |
	
	currentSize := parentSize.
	^ grammarRule fragments collect: [ :node | | generated |
		generated := self subNodeFrom: node parentSize: currentSize level: level.
		currentSize := currentSize - generated inputSize.
		generated 
	]
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> tree: word [

	^ PBTGrammarParser parse: word from: grammar
]
