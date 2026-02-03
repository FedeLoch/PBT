Extension { #name : 'Array' }

{ #category : '*Ume' }
Array >> mutateArray: anArray [

	^ (self, anArray) shuffle
]

{ #category : '*Ume' }
Array >> mutateDictionary: dict [

	^ dict mutateIntroducing: self
]

{ #category : '*Ume' }
Array >> mutateInteger: integer [

	^ self, { integer }
]

{ #category : '*Ume' }
Array >> mutateJson: anotherInput [

	anotherInput ifNil: [ ^ self ].

	^ anotherInput mutateArray: self
]

{ #category : '*Ume' }
Array >> mutateString: string [

	^ self, { string }
]
