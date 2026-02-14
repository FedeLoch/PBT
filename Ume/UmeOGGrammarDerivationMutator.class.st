Class {
	#name : 'UmeOGGrammarDerivationMutator',
	#superclass : 'UmeMutator',
	#instVars : [
		'grammar'
	],
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'instance creation' }
UmeOGGrammarDerivationMutator class >> from: aGrammar [

	^ self new grammar: aGrammar
]

{ #category : 'accessing' }
UmeOGGrammarDerivationMutator >> feed: feedback [

	feedback ifNotNil: [ | derivation improvement |
		[ derivation := grammar parse: feedback case ] on: Error do: [ ^ nil ].

		grammar backpropagate: derivation improvement: feedback improvement.
	]
]

{ #category : 'accessing' }
UmeOGGrammarDerivationMutator >> grammar: aGrammar [

	grammar := aGrammar 
]

{ #category : 'as yet unclassified' }
UmeOGGrammarDerivationMutator >> minimumRewardedNode: derivation [

	| worstReward worst |
	
	worstReward := SmallInteger maxVal.
	worst := OrderedCollection new.
	
	derivation allNodes do: [ :node | | reward |
		reward := node currentReward.
		(reward < worstReward) ifTrue: [ worstReward := reward . worst := OrderedCollection new ].
		(reward = worstReward) ifTrue: [ worst add: node ]
	].

	^ worst atRandom
	
]

{ #category : 'accessing' }
UmeOGGrammarDerivationMutator >> mutate: objectGraph [

	| derivation |

	derivation := grammar parse: (objectGraph veryDeepCopy).
	
	^ (self mutateDerivation: derivation) instance
]

{ #category : 'as yet unclassified' }
UmeOGGrammarDerivationMutator >> mutateDerivation: derivation [

	| node variant |
	
	"Select a node reward-based to mutate"
	node := self pickNode: derivation.

	"Replace the node with a new variant"
	variant := grammar genVariant: node.

	grammar replace: node by: variant.
	
	^ derivation	
]

{ #category : 'as yet unclassified' }
UmeOGGrammarDerivationMutator >> pickNode: derivation [

	^ self minimumRewardedNode: derivation
]
