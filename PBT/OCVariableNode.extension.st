Extension { #name : 'OCVariableNode' }

{ #category : '*PBT' }
OCVariableNode class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( properties variable )
]
