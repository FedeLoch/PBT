Class {
	#name : 'PBTObjectGrammarGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'grammar',
		'grammarGenerator'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
PBTObjectGrammarGenerator class >> from: anObjectGrammar [

	| generator |
	generator := PBTGrammarMCTSGenerator from: anObjectGrammar.

	^ self new grammarGenerator: generator; grammar: anObjectGrammar
]

{ #category : 'as yet unclassified' }
PBTObjectGrammarGenerator >> feed: feedback [

	grammarGenerator feed: feedback 
]

{ #category : 'as yet unclassified' }
PBTObjectGrammarGenerator >> gen: constraint [

	^ self generateObject: (grammarGenerator genDerivation: constraint) children first
]

{ #category : 'as yet unclassified' }
PBTObjectGrammarGenerator >> generateObject: grammarNode [
 
	^ grammarNode asPharoObject
]

{ #category : 'accessing' }
PBTObjectGrammarGenerator >> grammar: anObjectGrammar [

	grammar := anObjectGrammar.
	grammarGenerator grammar: anObjectGrammar.
]

{ #category : 'accessing' }
PBTObjectGrammarGenerator >> grammarGenerator: generator [

	grammarGenerator :=  generator
]
