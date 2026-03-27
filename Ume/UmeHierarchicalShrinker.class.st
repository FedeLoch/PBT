Class {
	#name : 'UmeHierarchicalShrinker',
	#superclass : 'UmeBaseShrinker',
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'shrinking' }
UmeHierarchicalShrinker >> shrink: input [

	| node current bestScore |
	current := input.
	bestScore := self evalInput: input.
	
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	"Level 1: Try to replace large subtrees with minimal equivalents"
	current := self shrinkLevel1: current from: bestScore.
	bestScore := self evalInput: current.
	
	"Level 2: Remove entire branches"
	current := self shrinkLevel2: current from: bestScore.
	bestScore := self evalInput: current.
	
	"Level 3: Reduce remaining structures"
	current := self shrinkLevel3: current from: bestScore.
	
	^ current
]

{ #category : 'shrinking' }
UmeHierarchicalShrinker >> shrinkLevel1: input from: bestScore [
	
	| node candidates |
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	candidates := self findReplaceableNodes: node.
	
	candidates do: [ :candidateNode |
		| replacement newInput |
		replacement := candidateNode minimalEquivalent.
		replacement ifNotNil: [
			newInput := self replaceNode: candidateNode with: replacement in: input.
			(self isStillValuable: (self evalInput: newInput) original: bestScore) ifTrue: [
				^ self shrinkLevel1: newInput from: (self evalInput: newInput) ] ] ].
	
	^ input
]

{ #category : 'shrinking' }
UmeHierarchicalShrinker >> shrinkLevel2: input from: bestScore [
	
	| node |
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	"Remove complete subtrees from leaves up"
	^ self removeSubtreesBottomUp: node from: bestScore originalInput: input
]

{ #category : 'shrinking' }
UmeHierarchicalShrinker >> shrinkLevel3: input from: bestScore [
	
	| node candidates |
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	"Aggressive character-level shrinking"
	candidates := (node allNodes select: [ :n | n isLeaf and: [ n inputSize > 0 ] ])
		sorted: [ :a :b | a inputSize < b inputSize ].
	
	candidates do: [ :leafNode |
		| parent grandparent newInput |
		parent := leafNode parent.
		parent ifNotNil: [
			grandparent := parent parent.
			grandparent ifNotNil: [
				"Try to reduce leaf content"
				leafNode children isEmpty ifFalse: [
					| minimalContent |
					minimalContent := leafNode minimalContent.
					minimalContent ~= leafNode asInput ifTrue: [
						newInput := self replaceNode: leafNode withContent: minimalContent in: input.
						(self isStillValuable: (self evalInput: newInput) original: bestScore) ifTrue: [
							^ self shrinkLevel3: newInput from: (self evalInput: newInput) ] ] ] ] ] ].
	
	^ input
]

{ #category : 'shrinking' }
UmeHierarchicalShrinker >> findReplaceableNodes: node [
	
	^ node allNodes select: [ :n |
		n respondsTo: #minimalEquivalent and: [
			n minimalEquivalent isNotNil ] ]
]

{ #category : 'shrinking' }
UmeHierarchicalShrinker >> removeSubtreesBottomUp: node from: bestScore originalInput: input [
	
	| sortedNodes |
	sortedNodes := node allNodes sorted: [ :a :b |
		a treeDepth > b treeDepth ].
	
	sortedNodes do: [ :targetNode |
		targetNode = node ifFalse: [
			| parent sibling newInput |
			parent := targetNode parent.
			parent ifNotNil: [
				sibling := targetNode sibling.
				sibling ifNotNil: [
					newInput := sibling asInput.
					(self isStillValuable: (self evalInput: newInput) original: bestScore) ifTrue: [
						^ self removeSubtreesBottomUp: (self parse: newInput) from: (self evalInput: newInput) originalInput: newInput ] ] ] ] ].
	
	^ input
]

{ #category : 'shrinking' }
UmeHierarchicalShrinker >> replaceNode: oldNode with: newNode in: input [
	
	| node |
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	"Find and replace in AST"
	node replaceNode: oldNode with: newNode.
	
	^ node asInput
]

{ #category : 'shrinking' }
UmeHierarchicalShrinker >> replaceNode: oldNode withContent: content in: input [
	
	| node |
	node := self parse: input.
	node ifNil: [ ^ input ].
	
	node replaceNodeContent: oldNode with: content.
	
	^ node asInput
]
