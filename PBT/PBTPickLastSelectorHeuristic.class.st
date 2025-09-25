Class {
	#name : 'PBTPickLastSelectorHeuristic',
	#superclass : 'PBTSelectorHeuristic',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'tree building' }
PBTPickLastSelectorHeuristic >> pickOne: candidates [

	^ candidates last
]
