Class {
	#name : 'MTAddSleepOperator',
	#superclass : 'MTPredicateBasedMutantOperator',
	#category : 'PBT-BugDetection',
	#package : 'PBT',
	#tag : 'BugDetection'
}

{ #category : 'printing' }
MTAddSleepOperator >> appliesToNode: aNode [

	^ aNode isMethod 
]

{ #category : 'printing' }
MTAddSleepOperator >> description [

	^ 'Add a sleep of X seconds at the beginning of a method'
]

{ #category : 'as yet unclassified' }
MTAddSleepOperator >> milliseconds [

	^ 10
]

{ #category : 'printing' }
MTAddSleepOperator >> newNodeFrom: anOldNode [

	| body |
	body := anOldNode body copy.
	body statements: { self node parent: body; yourself }, body statements.
	
	^ anOldNode copy body: body; yourself
]

{ #category : 'accessing' }
MTAddSleepOperator >> node [
	^ RBParser parseExpression: '(Delay forMilliseconds:', self milliseconds asString, ') wait'.
]
