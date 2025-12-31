Class {
	#name : 'PBTCorpusMinimizer',
	#superclass : 'Object',
	#category : 'PBT-Corpus Minimization',
	#package : 'PBT',
	#tag : 'Corpus Minimization'
}

{ #category : 'as yet unclassified' }
PBTCorpusMinimizer >> calculateGlobalRecords: feedbacks [

	| globalMax |
	globalMax := Dictionary new.
	feedbacks do: [ :fb | 
		fb values keysAndValuesDo: [ :key :value | 
			| currentMax |
			currentMax := globalMax at: key ifAbsent: [ 0 ].
			value > currentMax ifTrue: [ globalMax at: key put: value ] ] ].
	^ globalMax
]

{ #category : 'as yet unclassified' }
PBTCorpusMinimizer >> minimize: feedbacks [

	self subclassResponsibility 
]
