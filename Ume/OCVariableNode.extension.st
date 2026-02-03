Extension { #name : 'OCVariableNode' }

{ #category : '*Ume' }
OCVariableNode class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( properties variable )
]
