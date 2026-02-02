Class {
	#name : 'UmeGrammarParser',
	#superclass : 'Object',
	#instVars : [
		'wordToConsume',
		'memo'
	],
	#category : 'Ume-Grammar Parser',
	#package : 'Ume',
	#tag : 'Grammar Parser'
}

{ #category : 'instance creation' }
UmeGrammarParser class >> parse: string from: grammar [

	| parsingResult |
	parsingResult := self new parseNonTerminal: grammar start on: string from: 0.
	
	^ parsingResult ifNil: [ nil ] ifNotNil: [ parsingResult first ] 
]

{ #category : 'initialization' }
UmeGrammarParser >> best: best candidate: candidate [
	
	best ifNil: [ ^ candidate ].
	
	^ ((best first inputSize) < candidate first inputSize) ifTrue: [ candidate ] ifFalse: [ best ]
]

{ #category : 'initialization' }
UmeGrammarParser >> initialize [

	super initialize.
	memo := Dictionary new.
]

{ #category : 'initialization' }
UmeGrammarParser >> parseNonTerminal: nonTerminal on: input from: index [

	| key cached best |
    key := { nonTerminal . index }.
    cached := memo at: key ifAbsent: [ nil ].
    cached ifNotNil: [ ^ cached ].

    best := nil.

    nonTerminal rules do: [ :rule | | result candidate |
        result := self parseRule: rule on: input from: index.
        result ifNotNil: [
				candidate := GncInnerNode new tag: nonTerminal name; grammarRule: rule; children: result first.
				result at: 1 put: candidate.
            best := self best: best candidate: result
        ].
    ].

    memo at: key put: best.

    ^ best
]

{ #category : 'initialization' }
UmeGrammarParser >> parseRule: rule on: input from: index [

	| children currentIndex |
	children := OrderedCollection new.
	currentIndex := index.

	rule fragments do: [ :fragment | | result |
		result := fragment parse: input from: currentIndex with: self rule: rule.
		result ifNil: [ ^ nil ].
		children add: result first.
		currentIndex := result second
	].

	^ { children . currentIndex }
]

{ #category : 'parsing' }
UmeGrammarParser >> parseTerminal: terminal on: string from: index rule: rule [

    | token |

    token := terminal consume: string from: index.

    token ifNil: [ ^ nil ].

    ^ { (GncLeaf withToken: token) grammarRule: rule . index + token size }
]
