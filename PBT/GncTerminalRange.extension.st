Extension { #name : 'GncTerminalRange' }

{ #category : '*PBT' }
GncTerminalRange >> aMCTSValue [

	^ (from charCode to: to charCode) atRandom asCharacter
]
