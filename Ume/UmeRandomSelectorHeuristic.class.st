Class {
	#name : 'UmeRandomSelectorHeuristic',
	#superclass : 'UmeSelectorHeuristic',
	#category : 'Ume-Selector Heuristics',
	#package : 'Ume',
	#tag : 'Selector Heuristics'
}

{ #category : 'tree building' }
UmeRandomSelectorHeuristic >> pickOne: candidates [

	^ candidates atRandom 
]
