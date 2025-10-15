Class {
	#name : 'PBTTreeGrammarMutator',
	#superclass : 'PBTStringMutator',
	#instVars : [
		'maxInputSize',
		'grammar',
		'mutationProbability'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
PBTTreeGrammarMutator class >> from: aGrammar [

	^ self new gammar: aGrammar
]

{ #category : 'instance creation' }
PBTTreeGrammarMutator class >> from: aGrammar mutationProbability: prob [

	^ self new gammar: aGrammar; mutationProbability: prob
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> applyMutation: string [

	| ast |
	1 halt.
	ast := self tree: string.
1 halt.
	"We feed the grammar by doing backPropagation with the grammar"	
	ast backPropagateToChildren: 1 level: 0.
	1 halt.
	^ (self mutateTree: ast) asStringInput
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
PBTTreeGrammarMutator >> mutateTree: derivation [
	
	|  root currGrammarNode currDerivationNode parentSize level |
	
	root := derivation copy.
	currGrammarNode := grammar start.
	currDerivationNode := root.
	level := 0.
	
	[ self shouldApplyMutation: currDerivationNode ] whileFalse: [ | next nonTerminals |
		nonTerminals := currDerivationNode children reject: #isLeaf.
		nonTerminals isEmpty ifTrue: [ 1 halt ].
		next := nonTerminals atRandom.
		currGrammarNode := currDerivationNode grammarRule fragments detect: [ :fragment |
			(fragment isTerminal not) and: [ fragment name = next tag ]
		].
		currDerivationNode := next.
		level := level + 1.
	].

	parentSize := derivation generate size - (currDerivationNode generate size).

	currDerivationNode children: (self newSubtreeFrom: currGrammarNode parentSize: parentSize level: level) children.
	
	^ root	
]

{ #category : 'initialization' }
PBTTreeGrammarMutator >> mutationProbability: aProb [

	mutationProbability := aProb
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> newSubtreeFrom: node parentSize: parentSize level: level [

	| generator maxSize |
	maxSize := maxInputSize - parentSize.
	generator := generator := GrammarMCTSGenerator new
		             maxHeight: 20;
		             maxSize: maxSize + 60;
		             totalGenerations: 1;
		             explorationConstant: 1.41.

	^ node generateMCTSAst: generator level: level.
	
	"^ node generateAst: (GncGrammarGenerator newUnbounded maxSize: maxSize)"
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> shouldApplyMutation [

	^ (1 to: 100) atRandom <= mutationProbability "TODO: 10% of apply the mutation"
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> shouldApplyMutation: derivation [
	
	^ (self shouldApplyMutation) or: [ (derivation children reject: #isLeaf) isEmpty ]
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> tree: word [
	
	^ PBTGrammarParser parse: word from: grammar
]
