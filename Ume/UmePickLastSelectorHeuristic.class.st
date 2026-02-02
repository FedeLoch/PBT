Class {
	#name : 'UmePickLastSelectorHeuristic',
	#superclass : 'UmeSelectorHeuristic',
	#category : 'Ume-Selector Heuristics',
	#package : 'Ume',
	#tag : 'Selector Heuristics'
}

{ #category : 'tree building' }
UmePickLastSelectorHeuristic >> pickOne: candidates [

	^ candidates last
]
