Extension { #name : 'Boolean' }

{ #category : '*Ume' }
Boolean >> mutateArray: anArray [

	^ anArray, { self }
]

{ #category : '*Ume' }
Boolean >> mutateDictionary: dict [

	^ dict mutateIntroducing: self 
]

{ #category : '*Ume' }
Boolean >> mutateInteger: integer [

	^ self
]

{ #category : '*Ume' }
Boolean >> mutateJson: json [

	^ json mutatePrimitive: self
]

{ #category : '*Ume' }
Boolean >> mutateString: str [

	^ self
]
