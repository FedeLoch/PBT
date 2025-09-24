Class {
	#name : 'PBTGrammarGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'grammar',
		'generator'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTGrammarGenerator >> feed: feedback [

	"do nothing"
]

{ #category : 'accessing' }
PBTGrammarGenerator >> gen: myConstraint [

	"Gen a random string that matchs with the instance variable grammar"
	^ grammar generate: generator
]

{ #category : 'accessing' }
PBTGrammarGenerator >> grammar: aGrammar [

	grammar := aGrammar.
]

{ #category : 'accessing' }
PBTGrammarGenerator >> initialize [ 

	super initialize.
	generator := GncGrammarGenerator newUnbounded maxHeight: 20; maxSize: 20
]

{ #category : 'accessing' }
PBTGrammarGenerator >> maxHeight: aHeight [

	generator maxHeight: aHeight
]

{ #category : 'accessing' }
PBTGrammarGenerator >> maxSize: aSize [

	generator maxSize: aSize 
]
