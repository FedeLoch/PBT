Class {
	#name : 'UmeTournamentSelectorHeuristic',
	#superclass : 'UmeSelectorHeuristic',
	#instVars : [
		'tournamentSize'
	],
	#category : 'Ume-Selector Heuristics',
	#package : 'Ume',
	#tag : 'Selector Heuristics'
}

{ #category : 'accessing' }
UmeTournamentSelectorHeuristic >> defaultTournamentSize [

	^ 5
]

{ #category : 'initialization' }
UmeTournamentSelectorHeuristic >> initialize [

	super initialize.
	tournamentSize := self defaultTournamentSize
]

{ #category : 'tree building' }
UmeTournamentSelectorHeuristic >> pickOne: candidates feedbacks: feedbacks [
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
UmeTournamentSelectorHeuristic >> tournamentSize [

	tournamentSize ifNil: [ ^ self defaultTournamentSize ].

	^ tournamentSize
]

{ #category : 'accessing' }
UmeTournamentSelectorHeuristic >> tournamentSize: anInteger [

	tournamentSize := anInteger
]
