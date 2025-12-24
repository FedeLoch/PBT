Extension { #name : 'GncTerminalRange' }

{ #category : '*PBT' }
GncTerminalRange >> aMCTSValue [

	^ (from charCode to: to charCode) atRandom asCharacter
]

{ #category : '*PBT' }
GncTerminalRange >> minimumTree [
	
	^ GncLeaf withToken: (from charCode asCharacter)
]

{ #category : '*PBT' }
GncTerminalRange >> values [
	
	^ (from to: to) collect: #asString
]
