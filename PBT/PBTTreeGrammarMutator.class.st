Class {
	#name : 'PBTTreeGrammarMutator',
	#superclass : 'PBTStringMutator',
	#instVars : [
		'maxInputSize',
		'grammar',
		'mutationProbability',
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

	| ast |
	ast := self tree: string.

	"We feed the grammar by doing backPropagation with the grammar"	
	ast backPropagateToChildren: 1 level: 0.

	^ (self mutateAST: ast) asStringInput
]

{ #category : 'as yet unclassified' }
PBTTreeGrammarMutator >> gammar: aGrammar [
	
	grammar := aGrammar
]

{ #category : 'initialization' }
PBTTreeGrammarMutator >> initialize [

	super initialize.
	maxInputSize := SmallInteger maxVal.
	mutationProbability := 10.
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
PBTTreeGrammarMutator >> mutateAST: ast [
	
	| aNode node parentSize newChildren |

	aNode := self pickNode: ast.
	node := aNode isLeaf ifTrue: [ aNode parent ] ifFalse: [ aNode ].

	parentSize := ast generate size - (node generate size).

	newChildren := (self subNodesFrom: node grammarRule parentSize: parentSize level: (ast treeHeight - node treeHeight)).
	
	node children: newChildren.
	
	^ ast	
]

{ #category : 'initialization' }
PBTTreeGrammarMutator >> mutationProbability: aProb [

	mutationProbability := aProb
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> pickNode: ast [

	^ ast at: ((2 to: ast treeSize) atRandom)
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> shouldApplyMutation [

	^ (1 to: 100) atRandom <= mutationProbability
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> shouldApplyMutation: derivation [
	
	^ (self shouldApplyMutation) or: [ (derivation children reject: #isLeaf) isEmpty ]
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
