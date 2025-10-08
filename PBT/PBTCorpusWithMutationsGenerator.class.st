Class {
	#name : 'PBTCorpusWithMutationsGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'mutators',
		'corpus',
		'heuristic',
		'feedbacks',
		'seedGenerator',
		'mutationsPerIteration'
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

	^ self mutate: (self pickOne: constraint)
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
PBTCorpusWithMutationsGenerator >> mutate: seed [

	| m mutated times |
	m := (2 to: 12) atRandom. "TODO: The paper recommends powers between 2 and 128"
	mutated := seed.
	times := mutationsPerIteration ifNil: [ (2 ** m) ] ifNotNil: [ mutationsPerIteration ]. 
	times timesRepeat: [ mutated := self mutateOnce: mutated ].
	
	^ mutated
]

{ #category : 'as yet unclassified' }
PBTCorpusWithMutationsGenerator >> mutateOnce: input [

	^ mutators atRandom mutate: input
]

{ #category : 'accessing' }
PBTCorpusWithMutationsGenerator >> mutationsPerIteration [

	^ mutationsPerIteration
]

{ #category : 'accessing' }
PBTCorpusWithMutationsGenerator >> mutationsPerIteration: count [

	mutationsPerIteration := count
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
