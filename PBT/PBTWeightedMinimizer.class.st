Class {
	#name : 'PBTWeightedMinimizer',
	#superclass : 'PBTCorpusMinimizer',
	#instVars : [
		'costBlock'
	],
	#category : 'PBT-Corpus Minimization',
	#package : 'PBT',
	#tag : 'Corpus Minimization'
}

{ #category : 'accessing' }
PBTWeightedMinimizer >> costBlock: aBlock [

	costBlock := aBlock
]

{ #category : 'initialization' }
PBTWeightedMinimizer >> initialize [ 

	super initialize.
	"Default cost is 1 (equivalent to unweighted but with ratio logic)"
	costBlock := [ :fb | 1 ]
]

{ #category : 'as yet unclassified' }
PBTWeightedMinimizer >> minimize: feedbacks [

	| globalRecords universe remainingKeys minset fbsWithSatisfiedKeys |
	
	feedbacks ifEmpty: [ ^ #() ].
	
	globalRecords := self calculateGlobalRecords: feedbacks.
	universe := globalRecords keys select: [ :k | (globalRecords at: k) > 0 ].
	universe ifEmpty: [ ^ feedbacks ].

	fbsWithSatisfiedKeys := feedbacks collect: [ :fb | 
		fb -> (universe select: [ :k | (fb values at: k ifAbsent: [ 0 ]) = (globalRecords at: k) ]) ].

	minset := OrderedCollection new.
	remainingKeys := universe asSet.

	[ remainingKeys isNotEmpty ] whileTrue: [ 
		| bestMatch bestRatio |
		bestRatio := -1.
		bestMatch := nil.
		
		fbsWithSatisfiedKeys do: [ :assoc | 
			| uncoveredCount cost ratio |
			uncoveredCount := (assoc value intersection: remainingKeys) size.
			uncoveredCount > 0 ifTrue: [ 
				cost := costBlock value: assoc key.
				"Avoid division by zero"
				cost = 0 ifTrue: [ cost := 0.000001 ].
				ratio := uncoveredCount / cost.
				ratio > bestRatio ifTrue: [ 
					bestRatio := ratio.
					bestMatch := assoc ] ] ].
		
		"Safety check"
		bestMatch ifNil: [ ^ minset ].
		
		minset add: bestMatch key.
		remainingKeys removeAllFoundIn: bestMatch value.
	].

	^ minset
]
