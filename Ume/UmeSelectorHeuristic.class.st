Class {
	#name : 'UmeSelectorHeuristic',
	#superclass : 'Object',
	#category : 'Ume-Selector Heuristics',
	#package : 'Ume',
	#tag : 'Selector Heuristics'
}

{ #category : 'tree building' }
UmeSelectorHeuristic >> pickOne: candidates [

	self subclassResponsibility 
]

{ #category : 'tree building' }
UmeSelectorHeuristic >> pickOne: candidates feedbacks: feedbacks [

	^ self pickOne: candidates 
]
