Class {
	#name : 'UmeGrammarMCTSGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'totalGenerations',
		'explorationConstant',
		'lastDerivationTree',
		'grammar',
		'maxSize',
		'generator',
		'generatedTextInputs'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
UmeGrammarMCTSGenerator class >> from: grammar [

	^ self new grammar: grammar
]

{ #category : 'as yet unclassified' }
UmeGrammarMCTSGenerator >> aDerivation [
	
	totalGenerations := totalGenerations + 1.
	generator totalGenerations: totalGenerations.
		
	^ grammar start generateMCTSAst: generator level: 0
]

{ #category : 'as yet unclassified' }
UmeGrammarMCTSGenerator >> backpropagate: prevFeedback [

	| reward |
	
	lastDerivationTree ifNil: [ ^ nil ].

	"Update grammar reference production increasing total iterations and updating its reward.
	 Applies it recursively to the root"
	
	reward := self reward: prevFeedback.

	lastDerivationTree backPropagateToChildren: reward level: 0
]

{ #category : 'getter' }
UmeGrammarMCTSGenerator >> explorationConstant [

	^ explorationConstant.
]

{ #category : 'setter' }
UmeGrammarMCTSGenerator >> explorationConstant: aNumber [

	"The C in the formula of UTC"

	explorationConstant := aNumber
]

{ #category : 'as yet unclassified' }
UmeGrammarMCTSGenerator >> feed: feedback [

	"We are starting with this step because the feedback is got as a result of the last generation"
	self backpropagate: feedback
]

{ #category : 'as yet unclassified' }
UmeGrammarMCTSGenerator >> gen: constraint [

	^ (self genDerivation: constraint) asStringInput
]

{ #category : 'as yet unclassified' }
UmeGrammarMCTSGenerator >> genDerivation: constraint [

	"We update the production tree selected"
	lastDerivationTree := self getDerivationTree.
	generatedTextInputs at: lastDerivationTree asStringInput put: true.

	"We return its string representation"
	^ lastDerivationTree
]

{ #category : 'as yet unclassified' }
UmeGrammarMCTSGenerator >> getDerivationTree [

	| result |
	result := self aDerivation.

	[ generatedTextInputs includesKey: result asStringInput ] whileTrue: [
		result backPropagateToChildren: -1 level: 0.
		result := self aDerivation ].

	^ result
]

{ #category : 'setter' }
UmeGrammarMCTSGenerator >> grammar: aGrammar [

	grammar := aGrammar.
	totalGenerations := 0.
]

{ #category : 'as yet unclassified' }
UmeGrammarMCTSGenerator >> initialize [

	super initialize.
	totalGenerations := 0.
	explorationConstant := 1.41.
	maxSize := 40.
	generator := self newGenerator: maxSize.
	generatedTextInputs := Dictionary new
]

{ #category : 'setter' }
UmeGrammarMCTSGenerator >> maxSize: aSize [

	maxSize := aSize.
	generator := self newGenerator: aSize
]

{ #category : 'setter' }
UmeGrammarMCTSGenerator >> newGenerator: _maxSize [

	^ GrammarMCTSGenerator new maxHeight: 20; maxSize: _maxSize;
		totalGenerations: totalGenerations;
		explorationConstant: explorationConstant
]

{ #category : 'as yet unclassified' }
UmeGrammarMCTSGenerator >> reward: prevFeedback [

	prevFeedback ifNil: [ ^ 0 ].

	^ prevFeedback feedback ifTrue: [ 1 ] ifFalse: [ -1 ]
]
