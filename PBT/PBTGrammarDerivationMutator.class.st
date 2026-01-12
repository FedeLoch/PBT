Class {
	#name : 'PBTGrammarDerivationMutator',
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
PBTGrammarDerivationMutator class >> from: aGrammar [

	^ self new gammar: aGrammar
]

{ #category : 'accessing' }
PBTGrammarDerivationMutator >> applyMutation: string [

	| tree derivation |
	
	tree := self tree: string.
	derivation := tree ifNil: [ self freshAST ] ifNotNil: [ self mutateAST: tree ].

	^ derivation asStringInput
]

{ #category : 'accessing' }
PBTGrammarDerivationMutator >> feed: feedback [

	feedback ifNotNil: [ | ast improvement |
		[ ast := self tree: (feedback case) ] on: Error do: [ ^ nil ].
		ast ifNil: [ ^ nil ].
		
		"We feed the grammar by doing backPropagation with the grammar"
		improvement := (feedback isPositive) ifTrue: [ (feedback improvement) * 100 ] ifFalse: [ -1 ].
		ast backPropagateRecursive: improvement level: 0.
	]
]

{ #category : 'accessing' }
PBTGrammarDerivationMutator >> freshAST [

	^ self subNodeFrom: grammar start parentSize: 0 level: 0
]

{ #category : 'as yet unclassified' }
PBTGrammarDerivationMutator >> gammar: aGrammar [
	
	grammar := aGrammar
]

{ #category : 'as yet unclassified' }
PBTGrammarDerivationMutator >> grammar [

	^ grammar 
]

{ #category : 'initialization' }
PBTGrammarDerivationMutator >> initialize [

	super initialize.
	maxInputSize := SmallInteger maxVal.
	generator := GrammarMCTSGenerator new
		             maxHeight: SmallInteger maxVal;
		             totalGenerations: 1;
		             explorationConstant: 1.41
]

{ #category : 'testing' }
PBTGrammarDerivationMutator >> isReplace: string [

	^ string size >= maxInputSize
]

{ #category : 'accessing' }
PBTGrammarDerivationMutator >> maxInputSize: anInteger [

	maxInputSize := anInteger.
]

{ #category : 'accessing' }
PBTGrammarDerivationMutator >> minimumNodeRewarded: root [

	| worst worstReward worstNonTerminal | 
	worstReward := SmallInteger maxVal.
	worst := OrderedCollection new.
	
	root allNodes do: [ :node | | reward |
		reward := node reward: grammar root: root.
		(reward < worstReward) ifTrue: [ worstReward := reward . worst := OrderedCollection new ].
		(reward = worstReward) ifTrue: [ worst add: node ]
	].

	"We return a random non terminal node from the collection of worst ones"
	worstNonTerminal := worst select: [ :elem | elem isLeaf not ].
	
	^ (worstNonTerminal ifEmpty: [ worst ] ifNotEmpty: [ worstNonTerminal ]) atRandom
]

{ #category : 'accessing' }
PBTGrammarDerivationMutator >> mutateAST: ast [
	
	| aNode node parentSize newChildren |

	aNode := self pickNode: ast.
	node := aNode isLeaf ifTrue: [ aNode parent ] ifFalse: [ aNode ].

	parentSize := ast generate size - (node generate size).

	newChildren := (self subNodesFrom: node grammarRule parentSize: parentSize level: (ast treeHeight - node treeHeight)).
	
	node children: newChildren.
	
	^ ast	
]

{ #category : 'accessing' }
PBTGrammarDerivationMutator >> pickNode: ast [

	"10 % of selecting a random node"
	((1 to: 100) atRandom) <= 10 ifTrue: [ ^ ast at: ((2 to: ast treeSize) atRandom) ].

	"Select the node with minimum reward"
	^ self minimumNodeRewarded: ast
]

{ #category : 'accessing' }
PBTGrammarDerivationMutator >> subNodeFrom: grammarNode parentSize: parentSize level: level [

	| maxSize |

	maxSize := maxInputSize - parentSize.
	generator maxSize: maxSize + 1; totalGenerations: generator totalGenerations + 1.

	^ grammarNode generateMCTSAst: generator level: level.
]

{ #category : 'accessing' }
PBTGrammarDerivationMutator >> subNodesFrom: grammarRule parentSize: parentSize level: level [

	| currentSize |
	
	currentSize := parentSize.
	^ grammarRule fragments collect: [ :node | | generated |
		generated := self subNodeFrom: node parentSize: currentSize level: level.
		currentSize := currentSize - generated inputSize.
		generated 
	]
]

{ #category : 'accessing' }
PBTGrammarDerivationMutator >> tree: word [

	^ PBTGrammarParser parse: word from: grammar
]
