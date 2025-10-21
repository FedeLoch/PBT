Class {
	#name : 'PBTSelectorHeuristic',
	#superclass : 'Object',
	#category : 'PBT-Selector Heuristics',
	#package : 'PBT',
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
