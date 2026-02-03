Extension { #name : 'GncNonTerminal' }

{ #category : '*Ume' }
GncNonTerminal >> aMCTSValue [

]

{ #category : '*Ume' }
GncNonTerminal >> generateMCTSAst: generator level: level [

	^ generator visitNonTerminal: self level: level

]

{ #category : '*Ume' }
GncNonTerminal >> isTerminal [

	^ false
]

{ #category : '*Ume' }
GncNonTerminal >> minimumTree [

	| rule |
	rule := (rules sort: [ :n1 :n2 | (n1 minSize) <= (n2 minSize) ]) first.

	^ GncInnerNode new tag: self name; grammarRule: rule; children: rule minimumTree

]

{ #category : '*Ume' }
GncNonTerminal >> visit: visitor level: level [

	^ visitor visitNonTerminal: self level: level
]
