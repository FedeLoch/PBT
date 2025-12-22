Class {
	#name : 'PBTTournamentSelectorHeuristic',
	#superclass : 'PBTSelectorHeuristic',
	#instVars : [
		'tournamentSize'
	],
	#category : 'PBT-Selector Heuristics',
	#package : 'PBT',
	#tag : 'Selector Heuristics'
}

{ #category : 'accessing' }
PBTTournamentSelectorHeuristic >> defaultTournamentSize [

	^ 5
]

{ #category : 'initialization' }
PBTTournamentSelectorHeuristic >> initialize [

	super initialize.
	tournamentSize := self defaultTournamentSize
]

{ #category : 'tree building' }
PBTTournamentSelectorHeuristic >> pickOne: candidates feedbacks: feedbacks [
	| pool winner |
	
	feedbacks ifEmpty: [ ^ candidates atRandom ].
	
	"Select k random individuals"
	pool := (1 to: self tournamentSize) 
		collect: [ :i | feedbacks atRandom ].

	"Pick the best one from the pool based on improvement"
	winner := pool inject: pool first into: [ :best :current |
		(current improvement > best improvement) 
			ifTrue: [ current ] 
			ifFalse: [ best ] ].
			
	^ winner case
]

{ #category : 'accessing' }
PBTTournamentSelectorHeuristic >> tournamentSize [

	tournamentSize ifNil: [ ^ self defaultTournamentSize ].

	^ tournamentSize
]

{ #category : 'accessing' }
PBTTournamentSelectorHeuristic >> tournamentSize: anInteger [

	tournamentSize := anInteger
]
