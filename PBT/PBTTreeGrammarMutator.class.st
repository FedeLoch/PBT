Class {
	#name : 'PBTTreeGrammarMutator',
	#superclass : 'PBTStringMutator',
	#instVars : [
		'maxInputSize',
		'grammar',
		'mutationProbability',
		'generator'
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
PBTTreeGrammarMutator >> mutateAST: derivation [
	
	|  root currGrammarNode currDerivationNode parentSize level |
	
	root := derivation copy.
	currGrammarNode := grammar start.
	currDerivationNode := root.
	level := 0.
	
	[ self shouldApplyMutation: currDerivationNode ] whileFalse: [ | next nonTerminals |
		nonTerminals := currDerivationNode children reject: #isLeaf.
		next := nonTerminals atRandom.
		currGrammarNode := currDerivationNode grammarRule fragments detect: [ :fragment |
			(fragment isTerminal not) and: [ fragment name = next tag ]
		].
		currDerivationNode := next.
		level := level + 1.
	].

	parentSize := derivation generate size - (currDerivationNode generate size).

	currDerivationNode children:
		(self newSubtreeFrom: currGrammarNode parentSize: parentSize level: level) children.
	
	^ root	
]

{ #category : 'initialization' }
PBTTreeGrammarMutator >> mutationProbability: aProb [

	mutationProbability := aProb
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> newSubtreeFrom: node parentSize: parentSize level: level [

	| maxSize |
	maxSize := maxInputSize - parentSize.
	generator maxSize: maxSize + 1; totalGenerations: generator totalGenerations + 1.

	^ node generateMCTSAst: generator level: level.
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
PBTTreeGrammarMutator >> tree: word [
	
	^ PBTGrammarParser parse: word from: grammar
]
