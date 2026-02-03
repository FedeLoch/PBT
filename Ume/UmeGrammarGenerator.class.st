Class {
	#name : 'UmeGrammarGenerator',
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
UmeGrammarGenerator >> derivationTree: input [

	^ UmeGrammarParser parse: input from: grammar
]

{ #category : 'accessing' }
UmeGrammarGenerator >> feed: feedback [
	
	feedback ifNotNil: [ | ast |
		[ ast := self derivationTree: (feedback case) ] on: Error do: [ ^ nil ].
		
		ast ifNil: [ ^ nil ].
		
		"Increase/Decrease the weight of each production based on the feedback"
		ast updateWeightToChildren: ((feedback isPositive) ifTrue: [ 1 ] ifFalse: [ -1 ]).
	]
]

{ #category : 'accessing' }
UmeGrammarGenerator >> gen: myConstraint [

	"Gen a random string that matchs with the instance variable grammar"
	lastInput := grammar generate: generator.
	^ lastInput
	
]

{ #category : 'accessing' }
UmeGrammarGenerator >> grammar: aGrammar [

	grammar := aGrammar.
]

{ #category : 'accessing' }
UmeGrammarGenerator >> initialize [ 

	super initialize.
	generator := GncGrammarGenerator newUnbounded maxHeight: SmallInteger maxVal; maxSize: 20
]

{ #category : 'accessing' }
UmeGrammarGenerator >> maxHeight: aHeight [

	generator maxHeight: aHeight
]

{ #category : 'accessing' }
UmeGrammarGenerator >> maxSize: aSize [

	generator maxSize: aSize 
]
