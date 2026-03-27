Class {
	#name : 'UmeDeltaDebuggingShrinker',
	#superclass : 'UmeBaseShrinker',
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'shrinking' }
UmeDeltaDebuggingShrinker >> shrink: input [

	| current bestScore |
	current := input.
	bestScore := self evalInput: input.
	
	(self parse: input) ifNil: [ ^ input ].
	
	self shrinkWithDD: current from: 2 to: bestScore.
	
	^ current
]

{ #category : 'shrinking' }
UmeDeltaDebuggingShrinker >> shrinkWithDD: current from: granularity to: bestScore [
	
	| node partitions candidates |
	
	node := self parse: current.
	node ifNil: [ ^ self ].
	
	granularity > (node inputSize // 2) ifTrue: [ ^ self ].
	
	partitions := self splitIntoPartitions: node count: granularity.
	
	candidates := self removeFailingFragments: partitions from: current withScore: bestScore.
	
	candidates isEmpty
		ifTrue: [ 
			granularity = 2
				ifTrue: [ ^ self ].
			self shrinkWithDD: current from: (granularity // 2 max: 2) to: bestScore ]
		ifFalse: [ 
			current := candidates join.
			bestScore := self evalInput: current.
			self shrinkWithDD: current from: (granularity // 2 max: 2) to: bestScore ]
]

{ #category : 'shrinking' }
UmeDeltaDebuggingShrinker >> splitIntoPartitions: node count: count [

	| partitions partitionSize currentIndex |
	partitions := OrderedCollection new.
	partitionSize := (node inputSize / count) ceiling.
	currentIndex := 1.
	
	[ currentIndex <= node inputSize ] whileTrue: [
		| endIndex |
		endIndex := (currentIndex + partitionSize - 1) min: node inputSize.
		partitions add: (node sliceFrom: currentIndex to: endIndex).
		currentIndex := endIndex + 1
	].
	
	^ partitions
]

{ #category : 'shrinking' }
UmeDeltaDebuggingShrinker >> removeFailingFragments: partitions from: input withScore: bestScore [
	
	| result |
	result := OrderedCollection new.
	
	partitions do: [ :partition |
		| candidate |
		candidate := input copyWithoutAll: partition asInput.
		
		(self isStillValuable: (self evalInput: candidate) original: bestScore)
			ifTrue: [ result add: candidate ] ].
	
	^ result
]
