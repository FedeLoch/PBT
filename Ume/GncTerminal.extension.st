Extension { #name : 'GncTerminal' }

{ #category : '*Ume' }
GncTerminal >> aMCTSValue [

	self subclassResponsibility 
]

{ #category : '*Ume' }
GncTerminal >> generateMCTSAst: generator level: level [

	^ GncLeaf withToken: self aMCTSValue
]

{ #category : '*Ume' }
GncTerminal >> isTerminal [

	^ true
]

{ #category : '*Ume' }
GncTerminal >> minimumTree [

	self subclassResponsibility 
]

{ #category : '*Ume' }
GncTerminal >> values [
	
	self subclassResponsibility
]

{ #category : '*Ume' }
GncTerminal >> visit: visitor level: level [

	^ visitor visitTerminal: self level: level
]
