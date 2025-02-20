Extension { #name : 'GncTerminal' }

{ #category : '*PBT' }
GncTerminal >> aMCTSValue [

	self subclassResponsibility 
]

{ #category : '*PBT' }
GncTerminal >> generateMCTSAst: generator [

	^ GncLeaf withToken: self aMCTSValue
]
