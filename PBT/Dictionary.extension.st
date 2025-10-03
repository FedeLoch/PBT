Extension { #name : 'Dictionary' }

{ #category : '*PBT' }
Dictionary >> mutateArray: anArray [

	^ self mutateJson: anArray
]

{ #category : '*PBT' }
Dictionary >> mutateDictionary: dict [

	self associations do: [ :assoc |
		dict at: assoc key put: assoc value	
	].

	^ dict
]

{ #category : '*PBT' }
Dictionary >> mutateInteger: integer [

	^ self
]

{ #category : '*PBT' }
Dictionary >> mutateIntroducing: aValue [

	| nilKeys keyToMutate |
	nilKeys := self keys select: [ :key | (self at: key) isNil ].
	keyToMutate := nilKeys ifEmpty: [ self keys atRandom ] ifNotEmpty: [ nilKeys first ].
	
	self at: keyToMutate update: [ :value |
		value ifNil: [ aValue ] ifNotNil: [ value mutateJson: aValue ]
	].

	^ self
]

{ #category : '*PBT' }
Dictionary >> mutateJson: anotherJson [

	anotherJson ifNil: [ ^ self ].
	self ifEmpty: [ ^ anotherJson ].
	
	^ anotherJson mutateDictionary: self
]

{ #category : '*PBT' }
Dictionary >> mutateString: string [

	self at: string put: nil.
	
	^ self
]
