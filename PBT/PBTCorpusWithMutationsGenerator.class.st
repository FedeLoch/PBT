Class {
	#name : 'PBTCorpusWithMutationsGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'generator',
		'mutators',
		'corpus',
		'heuristic'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> addToCorpus: case [

	corpus add: case
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> feed: feedback [

	generator feed: feedback.
	
	feedback isPositive ifTrue: [ self addToCorpus: feedback case ]
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> gen: aConstraint [

	^ mutators inject: (self pickOne: aConstraint) into: [ :seed :mutator | mutator mutate: seed ]
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> generator: aGenerator [

	generator := aGenerator 
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> heuristic: aHeuristic [

	heuristic := aHeuristic 
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> initialize [ 
	
	super initialize.
	heuristic := PBTRandomSelectorHeuristic new.
	corpus := OrderedCollection new.
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> mutators: someMutators [

	mutators := someMutators 
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> pickOne: aConstraint [

	corpus ifEmpty: [ ^ generator gen: aConstraint ].
	
	^ heuristic pickOne: corpus
]
