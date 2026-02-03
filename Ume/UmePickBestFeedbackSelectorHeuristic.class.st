Class {
	#name : 'UmePickBestFeedbackSelectorHeuristic',
	#superclass : 'UmeSelectorHeuristic',
	#category : 'Ume-Selector Heuristics',
	#package : 'Ume',
	#tag : 'Selector Heuristics'
}

{ #category : 'tree building' }
UmePickBestFeedbackSelectorHeuristic >> pickOne: candidates feedbacks: feedbacks [

	candidates size = 1 ifTrue: [ ^ candidates at: 1 ].
	
	^ (feedbacks allButFirst inject: (feedbacks at: 2) into: [ :best :current |
			(current improvement > best improvement) ifTrue: [ current ] ifFalse: [ best ]
	]) case
]
