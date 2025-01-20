Class {
	#name : 'PBTHillClimbingGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'base',
		'lastMutated',
		'genBase',
		'mutate'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTHillClimbingGenerator >> gen: constraint by: aFeedback [

	base ifNil: [ self generateBase ].
	
	base := aFeedback ifTrue: [ lastMutated ] ifFalse: [ base ].
	
	lastMutated := self mutateBase.

	^ lastMutated
	
]

{ #category : 'as yet unclassified' }
PBTHillClimbingGenerator >> genBase: aBlock [

	genBase := aBlock 
]

{ #category : 'as yet unclassified' }
PBTHillClimbingGenerator >> generateBase [

	base := genBase value.
	lastMutated := base
	
]

{ #category : 'as yet unclassified' }
PBTHillClimbingGenerator >> mutate: aBlock [

	mutate := aBlock
]

{ #category : 'as yet unclassified' }
PBTHillClimbingGenerator >> mutateBase [

	^ mutate value: base
]
