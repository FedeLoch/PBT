Class {
	#name : 'PBTPickBestFeedbackSelectorHeuristic',
	#superclass : 'PBTSelectorHeuristic',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'tree building' }
PBTPickBestFeedbackSelectorHeuristic >> pickOne: candidates feedbacks: feedbacks [

	candidates size = 1 ifTrue: [ ^ candidates at: 1 ].
	
	^ (feedbacks allButFirst inject: (feedbacks at: 2) into: [ :best :current |
			(current improvement > best improvement) ifTrue: [ current ] ifFalse: [ best ]
	]) case
]
