Class {
	#name : 'PBTGrammarGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'grammar',
		'generator',
		'lastInput'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTGrammarGenerator >> derivationTree: input [

	^ PBTGrammarParser parse: input from: grammar
]

{ #category : 'accessing' }
PBTGrammarGenerator >> feed: feedback [
	
	feedback ifNotNil: [ | ast |
		[ ast := self derivationTree: (feedback case) ] on: Error do: [ ^ nil ].
		
		ast ifNil: [ ^ nil ].
		
		"Increase/Decrease the weight of each production based on the feedback"
		ast updateWeightToChildren: ((feedback isPositive) ifTrue: [ 1 ] ifFalse: [ -1 ]).
	]
]

{ #category : 'accessing' }
PBTGrammarGenerator >> gen: myConstraint [

	"Gen a random string that matchs with the instance variable grammar"
	lastInput := grammar generate: generator.
	^ lastInput
	
]

{ #category : 'accessing' }
PBTGrammarGenerator >> grammar: aGrammar [

	grammar := aGrammar.
]

{ #category : 'accessing' }
PBTGrammarGenerator >> initialize [ 

	super initialize.
	generator := GncGrammarGenerator newUnbounded maxHeight: SmallInteger maxVal; maxSize: 20
]

{ #category : 'accessing' }
PBTGrammarGenerator >> maxHeight: aHeight [

	generator maxHeight: aHeight
]

{ #category : 'accessing' }
PBTGrammarGenerator >> maxSize: aSize [

	generator maxSize: aSize 
]
