Class {
	#name : 'MTAddSleepOperator',
	#superclass : 'MTPredicateBasedMutantOperator',
	#instVars : [
		'milliseconds'
	],
	#category : 'PBT-Experimentation',
	#package : 'PBT',
	#tag : 'Experimentation'
}

{ #category : 'accessing' }
MTAddSleepOperator class >> time: milliseconds [

	^ self new milliseconds: milliseconds 
]

{ #category : 'printing' }
MTAddSleepOperator >> appliesToNode: aNode [

	^ aNode isSequence
]

{ #category : 'printing' }
MTAddSleepOperator >> description [

	^ 'Add a sleep of ', self milliseconds asString
]

{ #category : 'as yet unclassified' }
MTAddSleepOperator >> milliseconds [

	^ milliseconds
]

{ #category : 'as yet unclassified' }
MTAddSleepOperator >> milliseconds: someMilliseconds [

	milliseconds := someMilliseconds
]

{ #category : 'printing' }
MTAddSleepOperator >> newNodeFrom: aSequenceNode [

	| copy |
	copy := aSequenceNode copy.
	copy statements: { self node parent: copy; yourself }, copy statements.
	
	^ copy
]

{ #category : 'accessing' }
MTAddSleepOperator >> node [
	^ RBParser parseExpression: '(Delay forMilliseconds:', self milliseconds asString, ') wait'.
]

{ #category : 'accessing' }
MTAddSleepOperator >> title [
	
	^ self description.
]
