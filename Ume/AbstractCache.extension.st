Extension { #name : 'AbstractCache' }

{ #category : '*Ume' }
AbstractCache class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( factory )
]
