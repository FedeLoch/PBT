Extension { #name : 'GncTerminalRange' }

{ #category : '*Ume' }
GncTerminalRange >> aMCTSValue [

	^ (from charCode to: to charCode) atRandom asCharacter
]

{ #category : '*Ume' }
GncTerminalRange >> minimumTree [
	
	^ GncLeaf withToken: (from charCode asCharacter)
]

{ #category : '*Ume' }
GncTerminalRange >> values [
	
	^ (from to: to) collect: #asString
]
