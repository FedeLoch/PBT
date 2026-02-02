Class {
	#name : 'PBTPickLastSelectorHeuristic',
	#superclass : 'PBTSelectorHeuristic',
	#category : 'Ume-Selector Heuristics',
	#package : 'Ume',
	#tag : 'Selector Heuristics'
}

{ #category : 'tree building' }
PBTPickLastSelectorHeuristic >> pickOne: candidates [

	^ candidates last
]
