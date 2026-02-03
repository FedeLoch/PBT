Extension { #name : 'GncTerminalLiteral' }

{ #category : '*Ume' }
GncTerminalLiteral >> aMCTSValue [

	^ literal
]

{ #category : '*Ume' }
GncTerminalLiteral >> minimumTree [
	
	^ GncLeaf withToken: literal
]

{ #category : '*Ume' }
GncTerminalLiteral >> name [
	^ literal
]

{ #category : '*Ume' }
GncTerminalLiteral >> values [

	^ { literal }
]
