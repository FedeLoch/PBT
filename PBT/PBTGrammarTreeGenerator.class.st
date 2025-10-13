Class {
	#name : 'PBTGrammarTreeGenerator',
	#superclass : 'GncVisitor',
	#instVars : [
		'wordToConsume',
		'maxHeight',
		'maxSize',
		'ast'
	],
	#category : 'PBT-Grammars',
	#package : 'PBT',
	#tag : 'Grammars'
}

{ #category : 'instance creation' }
PBTGrammarTreeGenerator class >> from: string [

	^ self new wordToConsume: string
]

{ #category : 'accessing' }
PBTGrammarTreeGenerator >> ast [

	^ ast
]

{ #category : 'accessing' }
PBTGrammarTreeGenerator >> initialize [ 

	super initialize.
	maxHeight := 0.
	maxSize := 0.
	ast := nil
]

{ #category : 'accessing - attributes' }
PBTGrammarTreeGenerator >> maxHeight: height [

	maxHeight := height
]

{ #category : 'accessing - attributes' }
PBTGrammarTreeGenerator >> maxSize: size [

	maxSize := size
]

{ #category : 'accessing - attributes' }
PBTGrammarTreeGenerator >> offsetHeightCost: offset andSizeCost: size [

	^ self clone
		  maxHeight: maxHeight + offset;
		  maxSize: maxSize + size;
		  yourself
]

{ #category : 'visiting' }
PBTGrammarTreeGenerator >> selectRule: rules [

	^ rules detect: [ :rule | rule accept: wordToConsume ] ifNone: [ 1 halt. ]
]

{ #category : 'accessing' }
PBTGrammarTreeGenerator >> wordToConsume [

	^ wordToConsume
]

{ #category : 'accessing' }
PBTGrammarTreeGenerator >> wordToConsume: string [

	wordToConsume := string
]
