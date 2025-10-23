Extension { #name : 'OCMethodNode' }

{ #category : '*PBT' }
OCMethodNode class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( properties compilationContext )
]
