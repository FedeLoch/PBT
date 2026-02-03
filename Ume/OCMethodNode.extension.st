Extension { #name : 'OCMethodNode' }

{ #category : '*Ume' }
OCMethodNode class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( properties compilationContext pragmas )
]
