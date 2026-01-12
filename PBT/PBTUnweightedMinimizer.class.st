Class {
	#name : 'PBTUnweightedMinimizer',
	#superclass : 'PBTCorpusMinimizer',
	#category : 'PBT-Corpus Minimization',
	#package : 'PBT',
	#tag : 'Corpus Minimization'
}

{ #category : 'as yet unclassified' }
PBTUnweightedMinimizer >> minset: fbsWithSatisfiedKeys from: notZeroKeys [

	| minset remainingKeys |

	minset := OrderedCollection new.
	remainingKeys := notZeroKeys asSet.

	[ remainingKeys isNotEmpty ] whileTrue: [ | bestMatch |
		
		"Find the feedback that covers the most remaining keys"
		bestMatch := fbsWithSatisfiedKeys 
			detectMax: [ :assoc | (assoc value intersection: remainingKeys) size ].
			
		"bestMatch is the association feedback -> the categories that maximizes"
		
		"Safety check: if we can't cover more keys, return minset"
		(bestMatch value intersection: remainingKeys) isEmpty ifTrue: [ ^ minset ].

		minset add: bestMatch key.
		
		remainingKeys removeAllFoundIn: bestMatch value.
	].

	^ minset
]
