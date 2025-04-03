Class {
	#name : 'MTAddSleepOperator',
	#superclass : 'MTPredicateBasedMutantOperator',
	#instVars : [
		'milliseconds'
	],
	#category : 'PBT-BugDetection',
	#package : 'PBT',
	#tag : 'BugDetection'
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

	^ 'Add a sleep of X seconds at the beginning of a method'
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
