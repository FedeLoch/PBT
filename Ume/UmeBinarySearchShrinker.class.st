Class {
	#name : 'UmeBinarySearchShrinker',
	#superclass : 'UmeBaseShrinker',
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'shrinking' }
UmeBinarySearchShrinker >> shrink: input [

	| node bestScore current |
	current := input.
	bestScore := self evalInput: input.
	
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	maxIterations timesRepeat: [ | newScore |
		node := self parse: current.
		node ifNil: [ ^ current ].
		
		"Try binary halving"
		current := self shrinkByHalving: current from: bestScore.
		newScore := self evalInput: current.
		
		"Try removing second half"
		(newScore >= bestScore) ifFalse: [
			current := self shrinkByHalving: current from: bestScore startingAt: (current size // 2) ].
		
		"Try binary search on remaining"
		current := self binarySearch: current from: bestScore.
		
		bestScore := self evalInput: current.
	].
	
	^ current
]

{ #category : 'shrinking' }
UmeBinarySearchShrinker >> binarySearch: input from: bestScore [
	
	| left right currentSize midpoint |
	currentSize := input size.
	currentSize <= 1 ifTrue: [ ^ input ].
	
	left := 1.
	right := currentSize.
	
	[ left < right ] whileTrue: [
		midpoint := (left + right) // 2.
		
		"Try keeping left half"
		(self isStillValuable: (self evalInput: (input copyFrom: 1 to: midpoint)) original: bestScore)
			ifTrue: [ right := midpoint ]
			ifFalse: [
				"Try keeping right half"
				(self isStillValuable: (self evalInput: (input copyFrom: midpoint + 1 to: currentSize)) original: bestScore)
					ifTrue: [ left := midpoint + 1 ]
					ifFalse: [ ^ input ] ] ].
	
	^ input copyFrom: 1 to: left
]

{ #category : 'shrinking' }
UmeBinarySearchShrinker >> shrinkByHalving: input from: bestScore [
	
	^ self shrinkByHalving: input from: bestScore startingAt: 1
]

{ #category : 'shrinking' }
UmeBinarySearchShrinker >> shrinkByHalving: input from: bestScore startingAt: start [
	
	| size halfSize candidate |
	size := input size.
	size <= start ifTrue: [ ^ input ].
	
	halfSize := (size - start + 1) // 2.
	halfSize = 0 ifTrue: [ ^ input copyFrom: 1 to: start - 1 ].
	
	candidate := (input copyFrom: 1 to: start - 1), (input copyFrom: start + halfSize to: size).
	
	(self isStillValuable: (self evalInput: candidate) original: bestScore)
		ifTrue: [ 
			^ self shrinkByHalving: candidate from: (self evalInput: candidate) startingAt: start ].
	
	^ input
]
