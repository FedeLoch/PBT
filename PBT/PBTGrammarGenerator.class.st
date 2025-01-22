Class {
	#name : 'PBTGrammarGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'grammar',
		'fuzzer',
		'maxHeight'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTGrammarGenerator >> gen: myConstraint [

	"Gen a random string that matchs with the instance variable grammar"
	^ "fuzzer fuzz" grammar generate: (GncGrammarGenerator newUnbounded maxHeight: maxHeight; yourself)
]

{ #category : 'accessing' }
PBTGrammarGenerator >> grammar: aGrammar [

	grammar := aGrammar.
	fuzzer grammar: grammar
]

{ #category : 'accessing' }
PBTGrammarGenerator >> initialize [ 

	super initialize.
	fuzzer := PzGrammarFuzzer new.
	maxHeight := 20.
]

{ #category : 'accessing' }
PBTGrammarGenerator >> maxHeight [

	^ maxHeight 
]

{ #category : 'accessing' }
PBTGrammarGenerator >> maxHeight: aHeight [

	maxHeight := aHeight 
]
