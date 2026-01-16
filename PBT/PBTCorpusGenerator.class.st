Class {
	#name : 'PBTCorpusGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'mutators',
		'corpus',
		'heuristic',
		'feedbacks',
		'seedGenerator',
		'mutationsPerIteration',
		'seeds',
		'iteration'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> addToCorpus: feedback [

	corpus add: feedback case.
	feedbacks add: feedback
]

{ #category : 'accessing' }
PBTCorpusGenerator >> corpus: cases [ 

	corpus := cases
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> feed: feedback [

	mutators do: [ :mutator | mutator feed: feedback ].
	
	((feedback notNil) and: [ feedback isPositive ]) ifTrue: [
		self addToCorpus: feedback
	].
]

{ #category : 'accessing' }
PBTCorpusGenerator >> feedbacks: someFeedbacks [ 

	feedbacks := someFeedbacks
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> gen: constraint [

	iteration := iteration + 1.
	
	"First, we consume all the seeds"
	seeds ifNotEmpty: [ ^ self popSeed ].
	
	"Case where there is no seeds and the corpus is empty and a seed generator was provided"
	corpus isEmpty ifTrue: [ ^ self genSeed: constraint ].

	"Once the seeds have been consumed, we proceed to pick and mutate one element of the corpus"
	^ self mutate: (self pickOne: constraint)
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> genSeed: constraint [

	^ seedGenerator gen: constraint
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> heuristic: aHeuristic [

	heuristic := aHeuristic 
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> initialize [ 
	
	super initialize.
	heuristic := PBTRandomSelectorHeuristic new.
	corpus := OrderedCollection new.
	feedbacks := OrderedCollection new.
	seeds := OrderedCollection new.
	iteration := 0
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> minimizeCorpus [

	self feedbacks: (PBTUnweightedMinimizer new minimize: feedbacks).
	self corpus: (feedbacks collect: #case).
	
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> mutate: seed [

	| m mutated times |
	m := (2 to: 12) atRandom. "TODO: The paper recommends powers between 2 and 128"
	mutated := seed.
	times := mutationsPerIteration ifNil: [ (2 ** m) ] ifNotNil: [ mutationsPerIteration ]. 
	times timesRepeat: [ mutated := self mutateOnce: mutated ].
	
	^ mutated
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> mutateOnce: input [

	^ mutators atRandom mutate: input
]

{ #category : 'accessing' }
PBTCorpusGenerator >> mutationsPerIteration [

	^ mutationsPerIteration
]

{ #category : 'accessing' }
PBTCorpusGenerator >> mutationsPerIteration: count [

	mutationsPerIteration := count
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> mutators: someMutators [

	mutators := someMutators 
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> pickOne: constraint [
	
	^ heuristic pickOne: corpus feedbacks: feedbacks
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> popSeed [
	| top |
	
	top := seeds first.
	seeds := seeds allButFirst.
	
	^ top
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> seedGenerator: aGenerator [

	seedGenerator := aGenerator 
]

{ #category : 'as yet unclassified' }
PBTCorpusGenerator >> seeds: someSeeds [
	
	seeds := someSeeds 
]
