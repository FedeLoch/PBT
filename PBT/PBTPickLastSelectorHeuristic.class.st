Class {
	#name : 'PBTPickLastSelectorHeuristic',
	#superclass : 'PBTSelectorHeuristic',
	#category : 'PBT-Selector Heuristics',
	#package : 'PBT',
	#tag : 'Selector Heuristics'
}

{ #category : 'tree building' }
PBTPickLastSelectorHeuristic >> pickOne: candidates [

	^ candidates last
]
