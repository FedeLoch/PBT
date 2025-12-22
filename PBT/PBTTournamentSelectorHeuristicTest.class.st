Class {
	#name : 'PBTTournamentSelectorHeuristicTest',
	#superclass : 'TestCase',
	#category : 'PBT-Tests',
	#package : 'PBT',
	#tag : 'Tests'
}

{ #category : 'tests' }
PBTTournamentSelectorHeuristicTest >> testPickOneFromPool [
	| heuristic feedbacks result |
	
	heuristic := PBTTournamentSelectorHeuristic new.
	heuristic tournamentSize: 3.
	
	feedbacks := OrderedCollection new.
	feedbacks add: (PBTFeedback from: 'case1' improvement: 1 values: Dictionary new).
	feedbacks add: (PBTFeedback from: 'case2' improvement: 10 values: Dictionary new).
	feedbacks add: (PBTFeedback from: 'case3' improvement: 5 values: Dictionary new).
	feedbacks add: (PBTFeedback from: 'case4' improvement: 2 values: Dictionary new).
	
	"With a pool of 3 out of 4, it's highly likely to pick case2 or case3, but stochastic"
	"Let's force specific behavior or run multiple times to check distribution"
	
	result := heuristic pickOne: #(1 2 3 4) feedbacks: feedbacks.
	
	self assert: (#('case1' 'case2' 'case3' 'case4') includes: result).
]

{ #category : 'tests' }
PBTTournamentSelectorHeuristicTest >> testTournamentSize [
	| heuristic |
	heuristic := PBTTournamentSelectorHeuristic new.
	self assert: heuristic tournamentSize equals: 5.
	
	heuristic tournamentSize: 10.
	self assert: heuristic tournamentSize equals: 10.
]
