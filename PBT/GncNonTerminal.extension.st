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
GncNonTerminal >> visit: visitor level: level [

	^ visitor visitNonTerminal: self level: level
]
