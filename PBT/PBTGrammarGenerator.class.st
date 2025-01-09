Class {
	#name : 'PBTGrammarGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'grammar'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTGrammarGenerator >> gen: myConstraint [

	"Gen a random string that matchs with the instance variable grammar"
	^ (PzGrammarFuzzer new grammar: grammar) fuzz 
]

{ #category : 'accessing' }
PBTGrammarGenerator >> grammar: aGrammar [

	grammar := aGrammar 
]
