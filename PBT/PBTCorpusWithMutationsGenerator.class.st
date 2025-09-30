Class {
	#name : 'PBTCorpusWithMutationsGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'mutators',
		'corpus',
		'heuristic',
		'feedbacks',
		'seedGenerator'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> addToCorpus: feedback [

	corpus add: feedback case.
	feedbacks add: feedback
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> feed: feedback [

	((feedback notNil) and: [ feedback isPositive ]) ifTrue: [
		self addToCorpus: feedback
	]
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> gen: constraint [

	^ mutators inject: (self pickOne: constraint) into: [ :seed :mutator | mutator mutate: seed ]
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
	feedbacks := OrderedCollection new.
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> mutators: someMutators [

	mutators := someMutators 
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> pickOne: constraint [

	corpus ifEmpty: [ ^ self seed: constraint ].
	
	^ heuristic pickOne: corpus feedbacks: feedbacks
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> seed: constraint [

	^ seedGenerator gen: constraint
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> seedGenerator: aGenerator [

	seedGenerator := aGenerator 
]
