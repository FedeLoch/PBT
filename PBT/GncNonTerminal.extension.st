Extension { #name : 'GncNonTerminal' }

{ #category : '*PBT' }
GncNonTerminal >> aMCTSValue [

]

{ #category : '*PBT' }
GncNonTerminal >> generateMCTSAst: generator level: level [

	^ generator visitNonTerminal: self level: level

]

{ #category : '*PBT' }
GncNonTerminal >> isTerminal [

	^ false
]

{ #category : '*PBT' }
GncNonTerminal >> minimumTree [

	| rule |
	rule := (rules sort: [ :n1 :n2 | (n1 minSize) <= (n2 minSize) ]) first.

	^ GncInnerNode new tag: self name; grammarRule: rule; children: rule minimumTree

]

{ #category : '*PBT' }
GncNonTerminal >> visit: visitor level: level [

	^ visitor visitNonTerminal: self level: level
]
