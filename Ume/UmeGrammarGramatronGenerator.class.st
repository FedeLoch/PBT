Class {
	#name : 'UmeGrammarGramatronGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'grammar',
		'depth',
		'length',
		'lastDerivationTree',
		'transitions',
		'states',
		'finalStates',
		'initialState'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
UmeGrammarGramatronGenerator class >> from: grammar [

	^ self new grammar: grammar; depth: 20;  length: 40
]

{ #category : 'instance creation' }
UmeGrammarGramatronGenerator class >> from: grammar ofDepth: depth [

	^ self new grammar: grammar; depth: depth;  length: 40
]

{ #category : 'as yet unclassified' }
UmeGrammarGramatronGenerator >> addTransitionFrom: state on: terminal to: toState [

    | key |

    key := state -> terminal.
    (transitions at: key ifAbsentPut: [ OrderedCollection new ]) add: toState.
    states add: state; add: toState.
    finalStates add: toState.
]

{ #category : 'accessing' }
UmeGrammarGramatronGenerator >> allStates [

	^ states
]

{ #category : 'as yet unclassified' }
UmeGrammarGramatronGenerator >> backpropagate: previousFeedback [
 
	| reward |
	
	lastDerivationTree ifNil: [ ^ nil ].

	"Update grammar reference production increasing total iterations and updating its reward.
	 Applies it recursively to the root"
	
	reward := self reward: previousFeedback.
	
	lastDerivationTree backPropagateToChildren: reward level: 0
]

{ #category : 'accessing' }
UmeGrammarGramatronGenerator >> buildAutomaton [

	initialState := grammar start name.
	states add: initialState.

	grammar eachNonTerminal: [ :nonterminal |
		nonterminal rules do: [ :rule | | terminal toState |
			terminal := rule fragments first.
			toState := rule fragments
				           detect: [ :sym | sym isTerminal not ]
				           ifNone: [ #end ].
			toState ifNotNil: [
				self addTransitionFrom: nonterminal name on: terminal to: toState ] ] ]
]

{ #category : 'accessing' }
UmeGrammarGramatronGenerator >> depth [

	^ depth 
]

{ #category : 'accessing' }
UmeGrammarGramatronGenerator >> depth: aDepth [

	depth := aDepth 
]

{ #category : 'as yet unclassified' }
UmeGrammarGramatronGenerator >> feed: feedback [

	"do nothing"
]

{ #category : 'as yet unclassified' }
UmeGrammarGramatronGenerator >> gen: constraint [

	| input state nextOptions next |
	input := ''.
	state := self initialState.
	[ self isFinalState: state ] whileFalse: [ | nextState |
		nextOptions := transitions keys select: [ :key | key key  = state ].
		nextOptions isEmpty ifTrue: [ ^ input ].
		
		next := nextOptions atRandom.
		input := input, next value aMCTSValue.
		nextState := (self transitionsFrom: next key on: next value) atRandom.
		nextState == #end ifTrue: [ ^ input ].
		state := nextState name.
		].
	
	^ input
]

{ #category : 'accessing' }
UmeGrammarGramatronGenerator >> grammar [

	^ grammar 
]

{ #category : 'accessing' }
UmeGrammarGramatronGenerator >> grammar: aGrammar [

	grammar := aGrammar.
	transitions := Dictionary new.
	states := Set new.
	finalStates := Set new.
	self buildAutomaton.
]

{ #category : 'accessing' }
UmeGrammarGramatronGenerator >> initialState [

	^ initialState
]

{ #category : 'accessing' }
UmeGrammarGramatronGenerator >> isFinalState: state [

	^ finalStates includes: state
]

{ #category : 'accessing' }
UmeGrammarGramatronGenerator >> length [

	^ length
]

{ #category : 'accessing' }
UmeGrammarGramatronGenerator >> length: aLen [

	length := aLen
]

{ #category : 'as yet unclassified' }
UmeGrammarGramatronGenerator >> reward: prevFeedback [

	prevFeedback ifNil: [ ^ 0 ].

	^ prevFeedback feedback ifTrue: [ 1 ] ifFalse: [ -1 ]
]

{ #category : 'accessing' }
UmeGrammarGramatronGenerator >> splice: walk1 with: walk2 at: index [

	^ (walk1 copyFrom: 1 to: index),
		(walk2 copyFrom: index + 1 to: walk2 size)
]

{ #category : 'as yet unclassified' }
UmeGrammarGramatronGenerator >> transitionsFrom: fromState on: terminal [

	^ transitions at: fromState -> terminal ifAbsent: [ #(  ) ]
]
