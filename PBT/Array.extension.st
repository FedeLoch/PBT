Extension { #name : 'Array' }

{ #category : '*PBT' }
Array >> mutateArray: anArray [

	^ (self, anArray) shuffle
]

{ #category : '*PBT' }
Array >> mutateJson: anotherInput [

	anotherInput ifNil: [ ^ self ].

	^ anotherInput mutateArray: self
]
