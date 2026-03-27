Class {
	#name : 'UmeGreedyShrinker',
	#superclass : 'UmeBaseShrinker',
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'shrinking' }
UmeGreedyShrinker >> shrink: input [

	| node current bestScore changed |
	current := input.
	bestScore := self evalInput: input.
	
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	maxIterations timesRepeat: [
		changed := false.
		node := self parse: current.
		node ifNil: [ ^ current ].
		
		"Strategy 1: Remove largest subtrees first"
		current := self removeLargestSubtrees: current from: bestScore ifChanged: [ :c | current := c. changed := true ].
		
		"Strategy 2: Remove character by character from the end"
		changed ifFalse and: [ current size > 1 ] ifTrue: [
			current := self removeFromEnd: current from: bestScore ifChanged: [ :c | current := c. changed := true ] ].
		
		"Strategy 3: Remove from beginning"
		changed ifFalse and: [ current size > 1 ] ifTrue: [
			current := self removeFromBeginning: current from: bestScore ifChanged: [ :c | current := c. changed := true ] ].
		
		"Strategy 4: Remove alternating characters"
		changed ifFalse and: [ current size > 1 ] ifTrue: [
			current := self removeAlternating: current from: bestScore ifChanged: [ :c | current := c. changed := true ] ].
		
		changed ifFalse: [ ^ current ].
		bestScore := self evalInput: current.
	].
	
	^ current
]

{ #category : 'shrinking' }
UmeGreedyShrinker >> removeLargestSubtrees: input from: bestScore ifChanged: changeBlock [
	
	| node candidates sortedCandidates |
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	candidates := node allNodes reject: [ :n | n = node ].
	sortedCandidates := candidates sorted: [ :a :b | a inputSize > b inputSize ].
	
	sortedCandidates do: [ :candidateNode |
		| parent sibling |
		parent := candidateNode parent.
		parent ifNotNil: [
			sibling := candidateNode sibling.
			sibling ifNotNil: [
				| newInput |
				newInput := sibling asInput.
				(self isStillValuable: (self evalInput: newInput) original: bestScore) ifTrue: [
					changeBlock value: newInput.
					^ newInput ] ] ] ].
	
	^ input
]

{ #category : 'shrinking' }
UmeGreedyShrinker >> removeFromEnd: input from: bestScore ifChanged: changeBlock [
	
	[ input size > 1 ] whileTrue: [
		| candidate |
		candidate := input allButLast.
		(self isStillValuable: (self evalInput: candidate) original: bestScore) ifTrue: [
			changeBlock value: candidate.
			^ candidate ].
		input := candidate ].
	
	^ input
]

{ #category : 'shrinking' }
UmeGreedyShrinker >> removeFromBeginning: input from: bestScore ifChanged: changeBlock [
	
	[ input size > 1 ] whileTrue: [
		| candidate |
		candidate := input allButFirst.
		(self isStillValuable: (self evalInput: candidate) original: bestScore) ifTrue: [
			changeBlock value: candidate.
			^ candidate ].
		input := candidate ].
	
	^ input
]

{ #category : 'shrinking' }
UmeGreedyShrinker >> removeAlternating: input from: bestScore ifChanged: changeBlock [
	
	| size half candidate |
	size := input size.
	size <= 1 ifTrue: [ ^ input ].
	
	half := size // 2.
	candidate := String new: half.
	1 to: half do: [ :i | candidate at: i put: (input at: i * 2 - 1) ].
	
	(self isStillValuable: (self evalInput: candidate) original: bestScore) ifTrue: [
		changeBlock value: candidate.
		^ candidate ].
	
	^ input
]
