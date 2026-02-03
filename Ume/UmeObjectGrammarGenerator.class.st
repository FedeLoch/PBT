Class {
	#name : 'UmeObjectGrammarGenerator',
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
UmeObjectGrammarGenerator class >> from: anObjectGrammar [

	| generator |
	generator := UmeGrammarMCTSGenerator from: anObjectGrammar.

	^ self new grammarGenerator: generator; grammar: anObjectGrammar
]

{ #category : 'as yet unclassified' }
UmeObjectGrammarGenerator >> feed: feedback [

	grammarGenerator feed: feedback 
]

{ #category : 'as yet unclassified' }
UmeObjectGrammarGenerator >> gen: constraint [

	^ self generateObject: (grammarGenerator genDerivation: constraint) children first
]

{ #category : 'as yet unclassified' }
UmeObjectGrammarGenerator >> generateObject: grammarNode [
 
	^ grammarNode asPharoObject
]

{ #category : 'accessing' }
UmeObjectGrammarGenerator >> grammar: anObjectGrammar [

	grammar := anObjectGrammar.
	grammarGenerator grammar: anObjectGrammar.
]

{ #category : 'accessing' }
UmeObjectGrammarGenerator >> grammarGenerator: generator [

	grammarGenerator :=  generator
]
