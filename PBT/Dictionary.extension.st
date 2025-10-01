Extension { #name : 'Dictionary' }

{ #category : '*PBT' }
Dictionary >> mutateArray: anArray [

	^ self mutateJson: anArray
]

{ #category : '*PBT' }
Dictionary >> mutateJson: anotherJson [
	
	self at: (self keys atRandom) update: [ :value |
		value ifNil: [ anotherJson ] ifNotNil: [ value mutateJson: anotherJson ]
	]
]
