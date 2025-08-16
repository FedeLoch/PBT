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
GrammarMCTSGenerator >> ruleWithMoreUTC: rules level: level [

	^ rules sort: [ :rule :rule2 |
		  (rule utc: totalGenerations by: explorationConstant level: level)
		  >=
		  (rule2 utc: totalGenerations by: explorationConstant level: level) ]
]

{ #category : 'private' }
GrammarMCTSGenerator >> selectRule: rules level: level [

	| notVisited taken |
	
	rules detect: [ :rule | rule minSize <= maxSize ] ifNone: [ ^ nil ].
	
	notVisited := rules reject: [ :rule | rule visitedIn: level ].
	
	taken := (notVisited
		  ifEmpty: [ self ruleWithMoreUTC: rules level: level ]
		  ifNotEmpty: [ notVisited ]) first.
	
	^ (maxSize - taken minSize) < -1 ifTrue: [ nil ] ifFalse: [ taken ] 
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
	availableSize := maxSize" - 1".

	rule fragments do: [ :fragment |
		availableSize := availableSize - fragment minSize ].

	result := rule fragments collect: [ :fragment |
		          | node |
		          availableSize := availableSize + fragment minSize.
		          node := fragment
			                  visit: (self withSize: availableSize)
			                  level: level + 1.
		          node grammarRule: rule.

		          availableSize := availableSize - node treeSize.
		          node ].

	^ GncInnerNode with: result
]

{ #category : 'visiting' }
GrammarMCTSGenerator >> visitTerminal: terminal level: level [

	maxSize update: [ :size | size - 1 ].
	
	^ terminal generateMCTSAst: self level: level
]

{ #category : 'as yet unclassified' }
GrammarMCTSGenerator >> withSize: size [

	"TODO: omit this later, there is not necessary to clone all the time the same generator"
	
	^ self clone
		  maxSize: size;
		  yourself
]
