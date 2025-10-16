Class {
	#name : 'GrammarMCTSGenerator',
	#superclass : 'GncGrammarGenerator',
	#instVars : [
		'totalGenerations',
		'explorationConstant',
		'randomSelectionProb'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
GrammarMCTSGenerator >> explorationConstant: c [

	"The C in the formula of UTC"
	explorationConstant := c
]

{ #category : 'initialization' }
GrammarMCTSGenerator >> initialize [ 

	super initialize.
	randomSelectionProb := 15.
]

{ #category : 'as yet unclassified' }
GrammarMCTSGenerator >> ruleWithMoreUTC: rules level: level [

	| sorted |
	sorted := rules sort: [ :rule :rule2 |
		  (rule utc: totalGenerations by: explorationConstant level: level)
		  >
		  (rule2 utc: totalGenerations by: explorationConstant level: level) ].
	
	^ (1 to: 100) atRandom <= randomSelectionProb ifTrue: [ sorted atRandom ] ifFalse: [ sorted first ]
]

{ #category : 'private' }
GrammarMCTSGenerator >> selectRule: rules level: level [

	| notVisited taken |
	
	rules detect: [ :rule | rule minSize <= maxSize ] ifNone: [ ^ nil ].
	
	notVisited := rules reject: [ :rule | rule visitedIn: level ].
	
	taken := (notVisited
		  ifEmpty: [ self ruleWithMoreUTC: rules level: level ]
		  ifNotEmpty: [ notVisited atRandom ]).

	^ (maxSize - taken minSize) < -1 ifTrue: [ nil ] ifFalse: [ taken ] 
]

{ #category : 'initialization' }
GrammarMCTSGenerator >> totalGenerations [

	^ totalGenerations 
]

{ #category : 'accessing' }
GrammarMCTSGenerator >> totalGenerations: aNumber [
	totalGenerations := aNumber
]

{ #category : 'visiting' }
GrammarMCTSGenerator >> visitNonTerminal: nonTerminal level: level [
	
	| rule |
	
	rule := self selectRule: nonTerminal rules level: level.

	^ (rule ifNil: [ GncInnerNode with: {} ] ifNotNil: [ rule visit: self level: level ]) tag: nonTerminal name
	
]

{ #category : 'visiting' }
GrammarMCTSGenerator >> visitRule: rule level: level [

	| result availableSize |
	availableSize := maxSize.

	rule fragments do: [ :fragment |
		availableSize := availableSize - fragment minSize ].

	result := rule fragments collect: [ :fragment | | node prevSize |
		          availableSize := availableSize + fragment minSize.
		          prevSize := maxSize.
		          self maxSize: availableSize.

		          node := fragment visit: self level: level + 1.
		          node grammarRule: rule.

		          self maxSize: prevSize.
		          availableSize := availableSize - node inputSize.
		          node
	].

	^ GncInnerNode with: result
]

{ #category : 'visiting' }
GrammarMCTSGenerator >> visitTerminal: terminal level: level [

"	maxSize update: [ :size | size - 1 ]."
	
	^ terminal generateMCTSAst: self level: level
]
