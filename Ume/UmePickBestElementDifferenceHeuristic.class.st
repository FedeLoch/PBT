Class {
	#name : 'UmePickBestElementDifferenceHeuristic',
	#superclass : 'UmeSelectorHeuristic',
	#category : 'Ume-Selector Heuristics',
	#package : 'Ume',
	#tag : 'Selector Heuristics'
}

{ #category : 'as yet unclassified' }
UmePickBestElementDifferenceHeuristic >> best: feedbacks at: key [

	^ (feedbacks sort: [ :fb1 :fb2 | (fb1 values at: key) >= (fb2 values at: key) ]) first
]

{ #category : 'tree building' }
UmePickBestElementDifferenceHeuristic >> pickOne: candidates feedbacks: feedbacks [

	| bestForKey |

	bestForKey := feedbacks first values keys inject: Dictionary new into: [ :dict :key | | best |
		best := self best: feedbacks at: key.
		(best values at: key) > 0 ifTrue: [
			dict at: key put: best case.
		].
		dict
	].

	^ bestForKey atRandom
]
