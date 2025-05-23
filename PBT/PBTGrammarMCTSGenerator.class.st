Class {
	#name : 'PBTGrammarMCTSGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'totalGenerations',
		'explorationConstant',
		'lastDerivationTree',
		'grammar',
		'maxSize',
		'generator',
		'generatedTextInputs'
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
PBTGrammarMCTSGenerator >> aDerivation [
	
	generator
		maxSize: maxSize + 60;
		totalGenerations: totalGenerations;
		explorationConstant: explorationConstant.
		
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
PBTGrammarMCTSGenerator >> gen: constraint by: previousFeedback [

	"We are starting with this step because the feedback is got as a result of the last generation"
	self backpropagate: previousFeedback.

	"We update the production tree selected"

	lastDerivationTree := self getDerivationTree.
	totalGenerations := totalGenerations + 1.
	generatedTextInputs at: lastDerivationTree asStringInput put: true.

	"We return its string representation"
	^ lastDerivationTree asStringInput
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
	generator := (
		GrammarMCTSGenerator new maxHeight: 0;
			maxSize: maxSize + 60;
			totalGenerations: totalGenerations;
			explorationConstant: explorationConstant
	).
	generatedTextInputs := Dictionary new.
]

{ #category : 'setter' }
PBTGrammarMCTSGenerator >> maxSize: aSize [

	maxSize := aSize 
]

{ #category : 'as yet unclassified' }
PBTGrammarMCTSGenerator >> reward: prevFeedback [

	prevFeedback ifNil: [ ^ 0 ].

	^ prevFeedback feedback ifTrue: [ 1 ] ifFalse: [ -1 ]
]
