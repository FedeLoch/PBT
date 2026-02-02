Class {
	#name : 'PBTSelectorHeuristic',
	#superclass : 'Object',
	#category : 'Ume-Selector Heuristics',
	#package : 'Ume',
	#tag : 'Selector Heuristics'
}

{ #category : 'tree building' }
PBTSelectorHeuristic >> pickOne: candidates [

	self subclassResponsibility 
]

{ #category : 'tree building' }
PBTSelectorHeuristic >> pickOne: candidates feedbacks: feedbacks [

	^ self pickOne: candidates 
]
