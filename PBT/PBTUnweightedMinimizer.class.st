Class {
	#name : 'PBTUnweightedMinimizer',
	#superclass : 'PBTCorpusMinimizer',
	#category : 'PBT-Corpus Minimization',
	#package : 'PBT',
	#tag : 'Corpus Minimization'
}

{ #category : 'as yet unclassified' }
PBTUnweightedMinimizer >> minimize: feedbacks [

	| globalRecords universe satisfiedKeys minset remainingKeys fbsWithSatisfiedKeys |
	
	feedbacks ifEmpty: [ ^ #() ].
	
	globalRecords := self calculateGlobalRecords: feedbacks.
	universe := globalRecords keys select: [ :k | (globalRecords at: k) > 0 ].
	universe ifEmpty: [ ^ feedbacks ]. "Nothing to minimize if no records"

	"Map each feedback to the set of keys it 'conquered' (matches global max)"
	fbsWithSatisfiedKeys := feedbacks collect: [ :fb | 
		fb -> (universe select: [ :k | (fb values at: k ifAbsent: [ 0 ]) = (globalRecords at: k) ]) ].

	minset := OrderedCollection new.
	remainingKeys := universe asSet.

	[ remainingKeys isNotEmpty ] whileTrue: [ 
		| bestMatch |
		"Find the feedback that covers the most remaining keys"
		bestMatch := fbsWithSatisfiedKeys 
			detectMax: [ :assoc | (assoc value intersection: remainingKeys) size ].
		
		"Safety check: if we can't cover more keys, break"
		(bestMatch value intersection: remainingKeys) isEmpty ifTrue: [ ^ minset ].
		
		minset add: bestMatch key.
		remainingKeys removeAllFoundIn: bestMatch value.
	].

	^ minset
]
