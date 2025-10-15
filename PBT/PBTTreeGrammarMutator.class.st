Class {
	#name : 'PBTTreeGrammarMutator',
	#superclass : 'PBTStringMutator',
	#instVars : [
		'maxInputSize',
		'grammar'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
PBTTreeGrammarMutator class >> from: aGrammar [

	^ self new gammar: aGrammar
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> applyMutation: string [

	^ (self mutateTree: (self tree: string)) asStringInput
]

{ #category : 'as yet unclassified' }
PBTTreeGrammarMutator >> gammar: aGrammar [
	
	grammar := aGrammar
]

{ #category : 'initialization' }
PBTTreeGrammarMutator >> initialize [ 
	
	super initialize.
	maxInputSize := SmallInteger maxVal
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
	
	|  root currGrammarNode currDerivationNode parentSize |
	
	root := derivation copy.
	currGrammarNode := grammar start.
	currDerivationNode := root.
	
	[ self shouldApplyMutation: currDerivationNode ] whileFalse: [ | next nonTerminals |
		nonTerminals := currDerivationNode children reject: #isLeaf.
		nonTerminals isEmpty ifTrue: [ 1 halt ].
		next := nonTerminals atRandom.
		currGrammarNode := currDerivationNode grammarRule fragments detect: [ :fragment |
			(fragment isTerminal not) and: [ fragment name = next tag ]
		].
		currDerivationNode := next
	].

	parentSize := derivation generate size - (currDerivationNode generate size).
	
	currDerivationNode children: (self newSubtreeFrom: currGrammarNode parentSize: parentSize) children.
	
	^ root	
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> newSubtreeFrom: node [
	
	| value |
	value := node generateAst: GncGrammarGenerator newUnbounded. 
	^ value 
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> newSubtreeFrom: node parentSize: parentSize [
	
	^ node generateAst: (GncGrammarGenerator newUnbounded maxSize: (maxInputSize - parentSize))
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> shouldApplyMutation [

	^ (1 to: 100) atRandom <= 10 "TODO: 10% of apply the mutation"
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> shouldApplyMutation: derivation [
	
	^ (self shouldApplyMutation) or: [ (derivation children reject: #isLeaf) isEmpty ]
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> tree: word [
	
	^ PBTGrammarTreeGenerator parse: word from: grammar
]
