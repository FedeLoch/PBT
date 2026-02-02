Class {
	#name : 'PBTGrammarMCTSGenerator',
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
PBTGrammarMCTSGenerator class >> from: grammar [

	^ self new grammar: grammar
]

{ #category : 'as yet unclassified' }
PBTGrammarMCTSGenerator >> aDerivation [
	
	totalGenerations := totalGenerations + 1.
	generator totalGenerations: totalGenerations.
		
	^ grammar start generateMCTSAst: generator level: 0
]

{ #category : 'as yet unclassified' }
PBTGrammarMCTSGenerator >> backpropagate: prevFeedback [

	| reward |
	
	lastDerivationTree ifNil: [ ^ nil ].

	"Update grammar reference production increasing total iterations and updating its reward.
	 Applies it recursively to the root"
	
	reward := self reward: prevFeedback.

	lastDerivationTree backPropagateToChildren: reward level: 0
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
PBTGrammarMCTSGenerator >> feed: feedback [

	"We are starting with this step because the feedback is got as a result of the last generation"
	self backpropagate: feedback
]

{ #category : 'as yet unclassified' }
PBTGrammarMCTSGenerator >> gen: constraint [

	^ (self genDerivation: constraint) asStringInput
]

{ #category : 'as yet unclassified' }
PBTGrammarMCTSGenerator >> genDerivation: constraint [

	"We update the production tree selected"
	lastDerivationTree := self getDerivationTree.
	generatedTextInputs at: lastDerivationTree asStringInput put: true.

	"We return its string representation"
	^ lastDerivationTree
]

{ #category : 'as yet unclassified' }
PBTGrammarMCTSGenerator >> getDerivationTree [

	| result |
	result := self aDerivation.

	[ generatedTextInputs includesKey: result asStringInput ] whileTrue: [
		result backPropagateToChildren: -1 level: 0.
		result := self aDerivation ].

	^ result
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
	generator := self newGenerator: maxSize.
	generatedTextInputs := Dictionary new
]

{ #category : 'setter' }
PBTGrammarMCTSGenerator >> maxSize: aSize [

	maxSize := aSize.
	generator := self newGenerator: aSize
]

{ #category : 'setter' }
PBTGrammarMCTSGenerator >> newGenerator: _maxSize [

	^ GrammarMCTSGenerator new maxHeight: 20; maxSize: _maxSize;
		totalGenerations: totalGenerations;
		explorationConstant: explorationConstant
]

{ #category : 'as yet unclassified' }
PBTGrammarMCTSGenerator >> reward: prevFeedback [

	prevFeedback ifNil: [ ^ 0 ].

	^ prevFeedback feedback ifTrue: [ 1 ] ifFalse: [ -1 ]
]
