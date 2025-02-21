Class {
	#name : 'GrammarMCTSGenerator',
	#superclass : 'GncGrammarGenerator',
	#instVars : [
		'totalGenerations',
		'explorationConstant'
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

{ #category : 'as yet unclassified' }
GrammarMCTSGenerator >> ruleWithMoreUTC: rules [

	^ (rules sort: [ :rule :rule2 |
		   (rule utc: totalGenerations by: explorationConstant) >= (rule2
			   utc: totalGenerations
			   by: explorationConstant) ]) detect: [ :rule |
		  rule minSize <= maxSize ] ifNone: [ ^ nil ]
]

{ #category : 'private' }
GrammarMCTSGenerator >> selectRule: rules [

	| notVisited |
	
	notVisited := rules reject: #visited.

	^ notVisited
		  ifEmpty: [ self ruleWithMoreUTC: rules ]
		  ifNotEmpty: [ notVisited first ]
]

{ #category : 'accessing' }
GrammarMCTSGenerator >> totalGenerations: aNumber [

	totalGenerations := aNumber
]

{ #category : 'visiting' }
GrammarMCTSGenerator >> visitNonTerminal: nonTerminal [
	
	| rule |
	
	rule := self selectRule: nonTerminal rules.

	^ rule ifNil: [ ^ GncInnerNode with: {} ] ifNotNil: [ rule visit: self ]
	
]

{ #category : 'visiting' }
GrammarMCTSGenerator >> visitRule: rule [

	| result availableSize |
	
	rule visit.
	availableSize := maxSize - 1.

	rule fragments do: [ :fragment |
		availableSize := availableSize - fragment minSize ].

	result := rule fragments collect: [ :fragment |
		          | node |
		          availableSize := availableSize + fragment minSize.
		          node := fragment visit: (self withSize: availableSize).
		          node grammarRule: rule.
		          availableSize := availableSize - node treeSize.
		          node ].

	^ GncInnerNode with: result
]

{ #category : 'visiting' }
GrammarMCTSGenerator >> visitTerminal: terminal [

	maxSize update: [ :size | size - 1 ].
	
	^ terminal generateMCTSAst: self
]
