Class {
	#name : 'PBTRandomSelectorHeuristic',
	#superclass : 'PBTSelectorHeuristic',
	#category : 'Ume-Selector Heuristics',
	#package : 'Ume',
	#tag : 'Selector Heuristics'
}

{ #category : 'tree building' }
PBTRandomSelectorHeuristic >> pickOne: candidates [

	^ candidates atRandom 
]
