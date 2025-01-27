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
	
	base := (aFeedback notNil and: [ aFeedback ]) ifTrue: [ lastMutated ] ifFalse: [ base ].
	
	lastMutated := mutate value: base.
	
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
