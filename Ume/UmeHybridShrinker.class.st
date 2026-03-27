Class {
	#name : 'UmeHybridShrinker',
	#superclass : 'UmeBaseShrinker',
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'configuration' }
UmeHybridShrinker class >> strategies [
	
	^ { 
		#greedy -> [ :shrinker :input :score | shrinker shrinkGreedyStep: input from: score ].
		#binary -> [ :shrinker :input :score | shrinker shrinkBinaryStep: input from: score ].
		#delta -> [ :shrinker :input :score | shrinker shrinkDeltaStep: input from: score ].
		#bottomup -> [ :shrinker :input :score | shrinker shrinkBottomUpStep: input from: score ]
	}
]

{ #category : 'configuration' }
UmeHybridShrinker >> initialize [
	super initialize.
	strategy := #greedy.
]

{ #category : 'shrinking' }
UmeHybridShrinker >> shrink: input [

	| current bestScore iteration |
	current := input.
	bestScore := self evalInput: input.
	iteration := 0.
	
	(self parse: input) ifNil: [ ^ input ].
	
	[ iteration < maxIterations ] whileTrue: [
		| originalSize newScore changed |
		originalSize := current size.
		changed := false.
		
		"Try current strategy"
		current := self applyStrategy: strategy to: current from: bestScore.
		newScore := self evalInput: current.
		
		(newScore >= bestScore and: [ current size < originalSize ]) ifTrue: [
			bestScore := newScore.
			changed := true.
			strategy := #greedy "Reset to greedy after success"
		].
		
		"If no progress, try other strategies"
		changed ifFalse and: [ current size > 1 ] ifTrue: [
			| otherStrategies |
			otherStrategies := (self class strategies keys reject: [ :s | s = strategy ]) asOrderedCollection.
			
			[ otherStrategies isEmpty not and: [ changed not ] ] whileTrue: [
				| nextStrategy |
				nextStrategy := otherStrategies removeLast.
				current := self applyStrategy: nextStrategy to: current from: bestScore.
				newScore := self evalInput: current.
				
				(newScore >= bestScore and: [ current size < originalSize ]) ifTrue: [
					bestScore := newScore.
					changed := true.
					strategy := nextStrategy ] ] ].
		
		"No progress possible"
		changed ifFalse: [ ^ current ].
		
		iteration := iteration + 1
	].
	
	^ current
]

{ #category : 'shrinking' }
UmeHybridShrinker >> applyStrategy: strategyName to: input from: bestScore [
	
	| strategyBlock |
	strategyBlock := self class strategies at: strategyName ifAbsent: [ ^ input ].
	
	^ strategyBlock value: self value: input value: bestScore
]

{ #category : 'shrinking' }
UmeHybridShrinker >> shrinkGreedyStep: input from: bestScore [
	
	| node candidates |
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	candidates := (node allNodes reject: [ :n | n = node ])
		sorted: [ :a :b | a inputSize > b inputSize ].
	
	candidates do: [ :candidateNode |
		| parent sibling |
		parent := candidateNode parent.
		parent ifNotNil: [
			sibling := candidateNode sibling.
			sibling ifNotNil: [
				| newInput |
				newInput := sibling asInput.
				(self isStillValuable: (self evalInput: newInput) original: bestScore) ifTrue: [
					^ newInput ] ] ] ].
	
	^ input
]

{ #category : 'shrinking' }
UmeHybridShrinker >> shrinkBinaryStep: input from: bestScore [
	
	| size half |
	size := input size.
	size <= 1 ifTrue: [ ^ input ].
	
	half := size // 2.
	
	(self isStillValuable: (self evalInput: (input copyFrom: 1 to: half)) original: bestScore)
		ifTrue: [ ^ input copyFrom: 1 to: half ].
	
	(self isStillValuable: (self evalInput: (input copyFrom: half + 1 to: size)) original: bestScore)
		ifTrue: [ ^ input copyFrom: half + 1 to: size ].
	
	^ input
]

{ #category : 'shrinking' }
UmeHybridShrinker >> shrinkDeltaStep: input from: bestScore [
	
	| node partitions removable |
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	partitions := self splitInto: node count: 2.
	removable := partitions select: [ :p |
		| candidate |
		candidate := input copyWithoutAll: p asInput.
		self isStillValuable: (self evalInput: candidate) original: bestScore ].
	
	removable ifNotEmpty: [
		| result |
		result := input.
		removable do: [ :p | result := result copyWithoutAll: p asInput ].
		^ result ].
	
	^ input
]

{ #category : 'shrinking' }
UmeHybridShrinker >> shrinkBottomUpStep: input from: bestScore [
	
	| node leaves |
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	leaves := node allNodes select: [ :n | n isLeaf and: [ n parent notNil ] ].
	leaves := leaves sorted: [ :a :b | a treeDepth > b treeDepth ].
	
	leaves do: [ :leaf |
		| parent grandparent sibling newInput |
		parent := leaf parent.
		parent ifNotNil: [
			grandparent := parent parent.
			grandparent ifNotNil: [
				sibling := leaf sibling.
				sibling ifNotNil: [
					newInput := sibling asInput.
					(self isStillValuable: (self evalInput: newInput) original: bestScore) ifTrue: [
						^ newInput ] ] ] ] ].
	
	^ input
]

{ #category : 'shrinking' }
UmeHybridShrinker >> splitInto: node count: count [
	
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

{ #category : 'configuration' }
UmeHybridShrinker >> strategy [

	^ strategy
]

{ #category : 'configuration' }
UmeHybridShrinker >> strategy: aSymbol [

	strategy := aSymbol
]
