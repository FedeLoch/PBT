Class {
	#name : 'PBTGrammarMCTSGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'totalGenerations',
		'explorationConstant',
		'lastDerivationTree',
		'grammar',
		'maxSize'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
PBTGrammarMCTSGenerator class >> from: grammar [

	^ self new grammar: grammar
]

{ #category : 'as yet unclassified' }
PBTGrammarMCTSGenerator >> backpropagate: previousFeedback [

	| reward |
	
	lastDerivationTree ifNil: [ ^ nil ].
	
	reward := (previousFeedback isNotNil and: [ previousFeedback feedback ]) ifTrue: [ 1 ] ifFalse: [ -1 ].
	
	"Update grammar reference production increasing total iterations and updating its reward.
	 Applies it recursively to the root"
	lastDerivationTree backPropagateIteration: reward
]

{ #category : 'getter' }
PBTGrammarMCTSGenerator >> explorationConstant [

	^ explorationConstant.
]

{ #category : 'setter' }
PBTGrammarMCTSGenerator >> explorationConstant: aNumber [

	"The C in the formula of UTC"

	explorationConstant := aNumber
]

{ #category : 'as yet unclassified' }
PBTGrammarMCTSGenerator >> gen: constraint by: previousFeedback [

	"We are starting with this step because the feedback is got as a result of the last generation"
	self backpropagate: previousFeedback.
	
	"We update the production tree selected"
	lastDerivationTree := self getDerivationTree.
	totalGenerations := totalGenerations + 1.
	
	"We return its string representation"
	^ lastDerivationTree asString.
	
	
]

{ #category : 'as yet unclassified' }
PBTGrammarMCTSGenerator >> getDerivationTree [

	^ grammar start generateMCTSDerivation: totalGenerations maxSize: maxSize explorationConstant: explorationConstant
]

{ #category : 'setter' }
PBTGrammarMCTSGenerator >> grammar: aGrammar [

	grammar := aGrammar.
	totalGenerations := 0.
]

{ #category : 'as yet unclassified' }
PBTGrammarMCTSGenerator >> initialize [ 
	
	super initialize.
	totalGenerations := 0.
	explorationConstant := 1.41.
	maxSize := 40.
]

{ #category : 'setter' }
PBTGrammarMCTSGenerator >> maxSize: aSize [

	maxSize := aSize 
]
