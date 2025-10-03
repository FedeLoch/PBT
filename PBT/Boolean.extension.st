Extension { #name : 'Boolean' }

{ #category : '*PBT' }
Boolean >> mutateArray: anArray [

	^ anArray, { self }
]

{ #category : '*PBT' }
Boolean >> mutateDictionary: dict [

	^ dict mutateIntroducing: self 
]

{ #category : '*PBT' }
Boolean >> mutateInteger: integer [

	^ self
]

{ #category : '*PBT' }
Boolean >> mutateJson: json [

	^ json mutatePrimitive: self
]

{ #category : '*PBT' }
Boolean >> mutateString: str [

	^ self
]
