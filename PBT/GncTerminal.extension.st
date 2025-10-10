Extension { #name : 'GncTerminal' }

{ #category : '*PBT' }
GncTerminal >> aMCTSValue [

	self subclassResponsibility 
]

{ #category : '*PBT' }
GncTerminal >> generateMCTSAst: generator level: level [

	^ GncLeaf withToken: self aMCTSValue
]

{ #category : '*PBT' }
GncTerminal >> isTerminal [

	^ true
]

{ #category : '*PBT' }
GncTerminal >> values [
	
	self subclassResponsibility
]

{ #category : '*PBT' }
GncTerminal >> visit: visitor level: level [

	^ visitor visitTerminal: self level: level
]
