Extension { #name : 'Boolean' }

{ #category : '*PBT' }
Boolean >> mutateArray: anArray [

	^ anArray, { self }
]

{ #category : '*PBT' }
Boolean >> mutateJson: json [

	^ json mutatePrimitive: self
]
