Class {
	#name : 'PBTObjectGrammarGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'grammar',
		'grammarGenerator'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
PBTObjectGrammarGenerator class >> from: anObjectGrammar [

	| generator |
	generator := PBTGrammarMCTSGenerator from: anObjectGrammar.

	^ self new grammarGenerator: generator; grammar: anObjectGrammar
]

{ #category : 'as yet unclassified' }
PBTObjectGrammarGenerator >> gen: constraint by: previousFeedback [

	^ self generateObject: (grammarGenerator genDerivation: constraint by: previousFeedback) children first
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
