Class {
	#name : 'PBTGrammarTreeGenerator',
	#superclass : 'Object',
	#instVars : [
		'wordToConsume'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'instance creation' }
PBTGrammarTreeGenerator class >> parse: string from: grammar [

	^ self parseNonTerminal: string from: grammar start

	
]

{ #category : 'instance creation' }
PBTGrammarTreeGenerator class >> parseNonTerminal: string from: nonTerminal [

	| options |
	options := nonTerminal rules collect: [ :rule | | children node |
		children := self parseRule: string from: rule.
		GncInnerNode new tag: nonTerminal name; grammarRule: rule; children: children
	].
	
	"TODO: repear me later, i am returning just the first one that matches as much as possible"
	options sort: [ :node1 :node2 | node1 generate size >= node2 generate size ].
	
	^ options first
]

{ #category : 'parsing' }
PBTGrammarTreeGenerator class >> parseRule: string from: rule [ 
	
	"TODO: improve me, it tries to consume as much as possible always,
		it is not always true, check the case of A -> aC | abC, both match with 'a'
	"

	^ (rule fragments inject: { OrderedCollection new . string } into: [ :curr :fragment | | node |
		node := fragment parse: curr second with: self.
		curr first add: node.
		{ curr first . curr second allButFirst: (node generate size) }
	]) first.
	
]

{ #category : 'parsing' }
PBTGrammarTreeGenerator class >> parseTerminal: string from: terminal [ 

	^ GncLeaf withToken: (terminal consume: string)
]
