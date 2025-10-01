Extension { #name : 'SmallInteger' }

{ #category : '*PBT' }
SmallInteger >> mutateArray: anArray [

	^ anArray, { self }
]

{ #category : '*PBT' }
SmallInteger >> mutateJson: anotherJson [

	^ anotherJson
]
