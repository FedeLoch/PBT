Extension { #name : 'Array' }

{ #category : '*PBT' }
Array >> mutateArray: anArray [

	^ (self, anArray) shuffle
]

{ #category : '*PBT' }
Array >> mutateDictionary: dict [

	^ dict mutateIntroducing: self
]

{ #category : '*PBT' }
Array >> mutateInteger: integer [

	^ self, { integer }
]

{ #category : '*PBT' }
Array >> mutateJson: anotherInput [

	anotherInput ifNil: [ ^ self ].

	^ anotherInput mutateArray: self
]

{ #category : '*PBT' }
Array >> mutateString: string [

	^ self, { string }
]
