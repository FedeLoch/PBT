Class {
	#name : 'UmeHillClimbingGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'base',
		'lastMutated',
		'genBase',
		'mutate',
		'lastFeedback'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
UmeHillClimbingGenerator >> feed: aFeedback [

	lastFeedback := aFeedback.
	
	base := (lastFeedback notNil and: [ lastFeedback feedback ]) ifTrue: [ lastMutated ] ifFalse: [ base ]
]

{ #category : 'as yet unclassified' }
UmeHillClimbingGenerator >> gen: aConstraint [
	
	base ifNil: [ self generateBase ].
	
	lastMutated := mutate value: base value: aConstraint value: lastFeedback.
	
	^ lastMutated
]

{ #category : 'as yet unclassified' }
UmeHillClimbingGenerator >> genBase: aBlock [

	genBase := aBlock 
]

{ #category : 'as yet unclassified' }
UmeHillClimbingGenerator >> generateBase [

	base := genBase value.
	lastMutated := base
	
]

{ #category : 'as yet unclassified' }
UmeHillClimbingGenerator >> mutate: aBlock [

	mutate := aBlock
]
