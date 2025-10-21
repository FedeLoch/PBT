Class {
	#name : 'PBTRandomSelectorHeuristic',
	#superclass : 'PBTSelectorHeuristic',
	#category : 'PBT-Selector Heuristics',
	#package : 'PBT',
	#tag : 'Selector Heuristics'
}

{ #category : 'tree building' }
PBTRandomSelectorHeuristic >> pickOne: candidates [

	^ candidates atRandom 
]
