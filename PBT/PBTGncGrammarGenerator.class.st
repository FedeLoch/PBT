Class {
	#name : 'PBTGncGrammarGenerator',
	#superclass : 'GncGrammarGenerator',
	#instVars : [
		'grammar'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTGncGrammarGenerator >> grammar [

	^ grammar
]

{ #category : 'accessing' }
PBTGncGrammarGenerator >> grammar: aGrammar [

	grammar := aGrammar 
]

{ #category : 'visiting' }
PBTGncGrammarGenerator >> visitNonTerminal: aGncNonTerminal level: anInteger [ 

	^ self visitNonTerminal: aGncNonTerminal
]
