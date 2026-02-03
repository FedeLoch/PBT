Class {
	#name : 'UmeGrammarSdGenGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'grammar',
		'depth',
		'length',
		'lastDerivationTree'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
UmeGrammarSdGenGenerator class >> from: grammar [

	^ self new grammar: grammar; depth: 20;  length: 40
]

{ #category : 'instance creation' }
UmeGrammarSdGenGenerator class >> from: grammar ofDepth: depth [

	^ self new grammar: grammar; depth: depth;  length: 40
]

{ #category : 'as yet unclassified' }
UmeGrammarSdGenGenerator >> backpropagate: previousFeedback [
 
	| reward |
	
	lastDerivationTree ifNil: [ ^ nil ].

	"Update grammar reference production increasing total iterations and updating its reward.
	 Applies it recursively to the root"
	
	reward := self reward: previousFeedback.
	
	lastDerivationTree backPropagateToChildren: reward level: 0
]

{ #category : 'accessing' }
UmeGrammarSdGenGenerator >> depth [

	^ depth 
]

{ #category : 'accessing' }
UmeGrammarSdGenGenerator >> depth: aDepth [

	depth := aDepth 
]

{ #category : 'as yet unclassified' }
UmeGrammarSdGenGenerator >> expand: node depth: aDepth [

	| fragments |
	
	node isTerminal ifTrue: [ ^ node aMCTSValue ].
	
	aDepth >= depth ifTrue: [ ^ self getUntilTerminal: node ].

	fragments := (self selectRule: node at: aDepth) fragments.

	^ self expandFragments: fragments depth: aDepth + 1 accumulator: ''
]

{ #category : 'as yet unclassified' }
UmeGrammarSdGenGenerator >> expandFragments: fragments depth: aDepth accumulator: acc [

	| result |
	
	fragments ifEmpty: [ ^ acc ].

	result := self expand: fragments first depth: aDepth.
	
	^ self expandFragments: fragments allButFirst depth: aDepth accumulator: acc , result asString
]

{ #category : 'as yet unclassified' }
UmeGrammarSdGenGenerator >> feed: feedback [

	self backpropagate: feedback
]

{ #category : 'as yet unclassified' }
UmeGrammarSdGenGenerator >> gen: constraint [

	^ self expand: grammar start depth: 0
]

{ #category : 'as yet unclassified' }
UmeGrammarSdGenGenerator >> getUntilTerminal: node [

	node isTerminal ifTrue: [ ^ node aMCTSValue ].
	
	^ (node rules sorted: [ :r1 :r2 | r1 minSize < r2 minSize ]) first fragments inject: '' into: [ :r :n | r, (self getUntilTerminal: n) asString ] 
]

{ #category : 'accessing' }
UmeGrammarSdGenGenerator >> grammar [

	^ grammar 
]

{ #category : 'accessing' }
UmeGrammarSdGenGenerator >> grammar: aGrammar [

	grammar := aGrammar 
]

{ #category : 'accessing' }
UmeGrammarSdGenGenerator >> length [

	^ length
]

{ #category : 'accessing' }
UmeGrammarSdGenGenerator >> length: aLen [

	length := aLen
]

{ #category : 'as yet unclassified' }
UmeGrammarSdGenGenerator >> reward: prevFeedback [

	prevFeedback ifNil: [ ^ 0 ].

	^ prevFeedback feedback ifTrue: [ 1 ] ifFalse: [ -1 ]
]

{ #category : 'as yet unclassified' }
UmeGrammarSdGenGenerator >> selectRule: node at: level [

	| totalWeights weights indexes selected |

	totalWeights := (node rules collect: [ :r | r weightAt: level ]) sum.
	weights := OrderedCollection new.
	
	indexes := node rules collect: [ :r | | current |
		current := (weights isEmpty ifTrue: [0] ifFalse: [ weights last ]).
		weights add: (current + (r weightAt: level)).
		node rules indexOf: r
	].
	
	selected := (1 to: totalWeights) atRandom.
	
	^ node rules at: (indexes detect: [ :index | selected <= (weights at: index) ])
]
