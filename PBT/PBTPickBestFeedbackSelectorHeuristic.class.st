Class {
	#name : 'PBTPickBestFeedbackSelectorHeuristic',
	#superclass : 'PBTSelectorHeuristic',
	#category : 'PBT-Selector Heuristics',
	#package : 'PBT',
	#tag : 'Selector Heuristics'
}

{ #category : 'tree building' }
PBTPickBestFeedbackSelectorHeuristic >> pickOne: candidates feedbacks: feedbacks [

	candidates size = 1 ifTrue: [ ^ candidates at: 1 ].
	
	^ (feedbacks allButFirst inject: (feedbacks at: 2) into: [ :best :current |
			(current improvement > best improvement) ifTrue: [ current ] ifFalse: [ best ]
	]) case
]
