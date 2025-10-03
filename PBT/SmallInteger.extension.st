Extension { #name : 'SmallInteger' }

{ #category : '*PBT' }
SmallInteger >> mutateArray: anArray [

	^ anArray, { self }
]

{ #category : '*PBT' }
SmallInteger >> mutateDictionary: dict [

	^ dict mutateIntroducing: self
]

{ #category : '*PBT' }
SmallInteger >> mutateInteger: integer [

	^ self + integer 
]

{ #category : '*PBT' }
SmallInteger >> mutateJson: anotherJson [

	^ anotherJson mutateInteger: self
]

{ #category : '*PBT' }
SmallInteger >> mutateString: string [

	^ self 
]
