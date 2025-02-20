Extension { #name : 'GncNonTerminal' }

{ #category : '*PBT' }
GncNonTerminal >> generateMCTSAst: generator [

	^ generator visitNonTerminal: self

]
