Class {
	#name : 'PBTSelectorHeuristic',
	#superclass : 'Object',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'tree building' }
PBTSelectorHeuristic >> pickOne: candidates [

	self subclassResponsibility 
]
