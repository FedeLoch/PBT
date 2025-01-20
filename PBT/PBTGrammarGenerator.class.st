Class {
	#name : 'PBTGrammarGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'grammar',
		'fuzzer'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTGrammarGenerator >> gen: myConstraint [

	"Gen a random string that matchs with the instance variable grammar"
	^ fuzzer fuzz 
]

{ #category : 'accessing' }
PBTGrammarGenerator >> grammar: aGrammar [

	grammar := aGrammar.
	fuzzer grammar: grammar
]

{ #category : 'accessing' }
PBTGrammarGenerator >> initialize [ 

	super initialize.
	fuzzer := PzGrammarFuzzer new
]
