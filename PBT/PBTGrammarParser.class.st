Class {
	#name : 'PBTGrammarParser',
	#superclass : 'Object',
	#instVars : [
		'wordToConsume',
		'memo'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'instance creation' }
PBTGrammarParser class >> parse: string from: grammar [

	^ (self new parseNonTerminal: grammar start on: string from: 0) first

	
]

{ #category : 'initialization' }
PBTGrammarParser >> best: best candidate: candidate [
	
	best ifNil: [ ^ candidate ].
	
	^ ((best first inputSize) < candidate first inputSize) ifTrue: [ candidate ] ifFalse: [ best ]
]

{ #category : 'initialization' }
PBTGrammarParser >> initialize [

	super initialize.
	memo := Dictionary new.
]

{ #category : 'initialization' }
PBTGrammarParser >> parseNonTerminal: nonTerminal on: input from: index [

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
PBTGrammarParser >> parseRule: rule on: input from: index [

	| children currentIndex |
	children := OrderedCollection new.
	currentIndex := index.

	rule fragments do: [ :fragment | | result |
		result := fragment parse: input from: currentIndex with: self.
		result ifNil: [ ^ nil ].
		children add: result first.
		currentIndex := result second
	].

	^ { children . currentIndex }
]

{ #category : 'parsing' }
PBTGrammarParser >> parseTerminal: terminal on: string from: index [

    | token |

    token := terminal consume: string from: index.

    token ifNil: [ ^ nil ].

    ^ { GncLeaf withToken: token . index + token size }
]
