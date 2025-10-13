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
PBTTreeGrammarMutator >> mutateTree: ast [

	1 halt.
]

{ #category : 'accessing' }
PBTTreeGrammarMutator >> tree: string [
	
	| generator |
	generator := PBTGrammarTreeGenerator from: string.
	grammar generateAst: generator.
	
	^ generator ast
]
