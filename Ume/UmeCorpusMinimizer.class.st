Class {
	#name : 'UmeCorpusMinimizer',
	#superclass : 'Object',
	#category : 'Ume-Corpus Minimization',
	#package : 'Ume',
	#tag : 'Corpus Minimization'
}

{ #category : 'as yet unclassified' }
UmeCorpusMinimizer >> globalMax: feedbacks [

	"This should be the same as the current max in the feedback evaluator"
	^ feedbacks inject: Dictionary new into: [ :globalMax : feedback |
		feedback values keysAndValuesDo: [ :key :category | | currentMax |
			currentMax := globalMax at: key ifAbsent: [ 0 ].
			category > currentMax ifTrue: [ globalMax at: key put: category ] ].
		globalMax
	]

]

{ #category : 'as yet unclassified' }
UmeCorpusMinimizer >> minimize: feedbacks [

	| globalMax universe fbsWithSatisfiedKeys |

	feedbacks ifEmpty: [ ^ #() ].
	
	globalMax := self globalMax: feedbacks.
	universe := globalMax keys select: [ :k | (globalMax at: k) > 0 ].
	universe ifEmpty: [ ^ feedbacks ].

	fbsWithSatisfiedKeys := self satisfiedKeys: feedbacks globalMax: globalMax.
	
	^ self minset: fbsWithSatisfiedKeys from: universe
]

{ #category : 'as yet unclassified' }
UmeCorpusMinimizer >> minset: fbsWithSatisfiedKeys from: notZeroKeys [

	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
UmeCorpusMinimizer >> satisfiedKeys: feedbacks globalMax: globalMax [
	
	^ feedbacks collect: [ :feedback | 
		feedback -> (globalMax keys select: [ :k | (feedback values at: k ifAbsent: [ 0 ]) = (globalMax at: k) ]) ]
]
