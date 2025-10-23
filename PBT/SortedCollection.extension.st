Extension { #name : 'SortedCollection' }

{ #category : '*PBT' }
SortedCollection class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( sortBlock )
]
