Class {
	#name : 'UmeCorpusGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'mutators',
		'corpus',
		'heuristic',
		'feedbacks',
		'seedGenerator',
		'mutationsPerIteration',
		'seeds',
		'iteration',
		'lastSelectedMutator'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> addToCorpus: feedback [

	corpus add: feedback case.
	feedbacks add: feedback
]

{ #category : 'accessing' }
UmeCorpusGenerator >> corpus: cases [ 

	corpus := cases
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> feed: feedback [

	mutators do: [ :mutator | mutator feed: feedback ].
	
	self updateWeight: feedback.
	
	((feedback notNil) and: [ feedback isPositive or: [ corpus isEmpty ] ]) ifTrue: [
		self addToCorpus: feedback
	]
]

{ #category : 'accessing' }
UmeCorpusGenerator >> feedbacks: someFeedbacks [ 

	feedbacks := someFeedbacks
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> gen: constraint [

	iteration := iteration + 1.
	
	"First, we consume all the seeds"
	seeds ifNotEmpty: [ ^ self popSeed ].
	
	"Case where there is no seeds and the corpus is empty and a seed generator was provided"
	corpus isEmpty ifTrue: [ ^ self genSeed: constraint ].

	"Once the seeds have been consumed, we proceed to pick and mutate one element of the corpus"
	^ self mutate: (self pickOne: constraint)
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> genSeed: constraint [

	^ seedGenerator gen: constraint
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> heuristic: aHeuristic [

	heuristic := aHeuristic 
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> initialize [ 
	
	super initialize.
	heuristic := UmeRandomSelectorHeuristic new.
	corpus := OrderedCollection new.
	feedbacks := OrderedCollection new.
	seeds := OrderedCollection new.
	iteration := 0
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> minimizeCorpus [

	self feedbacks: (UmeUnweightedMinimizer new minimize: feedbacks).
	self corpus: (feedbacks collect: #case).
	
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> mutate: seed [

	| m mutated times |
	m := (2 to: 12) atRandom.
	mutated := seed.
	times := mutationsPerIteration ifNil: [ (2 ** m) ] ifNotNil: [ mutationsPerIteration ].
	lastSelectedMutator := self selectMutator.
	
	times timesRepeat: [ mutated := lastSelectedMutator mutate: mutated ].
	
	^ mutated
]

{ #category : 'accessing' }
UmeCorpusGenerator >> mutationsPerIteration [

	^ mutationsPerIteration
]

{ #category : 'accessing' }
UmeCorpusGenerator >> mutationsPerIteration: count [

	mutationsPerIteration := count
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> mutators: someMutators [

	mutators := someMutators 
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> pickOne: constraint [

	^ heuristic pickOne: corpus feedbacks: feedbacks
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> popSeed [
	| top |
	
	top := seeds first.
	seeds := seeds allButFirst.
	
	^ top
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> seedGenerator: aGenerator [

	seedGenerator := aGenerator 
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> seeds: someSeeds [
	
	seeds := someSeeds 
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> selectMutator [

	| totalWeights weights indexes random |

	totalWeights := (mutators collect: #weight) sum.
	weights := OrderedCollection new.
	
	indexes := mutators collect: [ :wrapper | | current |
		current := (weights isEmpty ifTrue: [ 0 ] ifFalse: [ weights last ]).
		weights add: (current + wrapper weight).
		mutators indexOf: wrapper
	].
	
	random := (1 to: totalWeights) atRandom.
	
	^ mutators at: (indexes detect: [ :index | random <= (weights at: index) ])
]

{ #category : 'as yet unclassified' }
UmeCorpusGenerator >> updateWeight: feedback [

	(lastSelectedMutator isNil or: [ feedback isNil ]) ifTrue: [ ^ nil ].

	feedback isPositive
		ifTrue: [ lastSelectedMutator increaseWeight ]
		ifFalse: [ lastSelectedMutator decreaseWeight ]
]
