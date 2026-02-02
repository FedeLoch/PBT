Extension { #name : 'SortedCollection' }

{ #category : '*Ume' }
SortedCollection class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( sortBlock )
]
