Extension { #name : 'AeCanvas' }

{ #category : '*Ume' }
AeCanvas class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( backgroundSourceBlock pathBlock figureBlock borderBlock )
]
