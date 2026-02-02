Extension { #name : 'SmallInteger' }

{ #category : '*Ume' }
SmallInteger >> mutateArray: anArray [

	^ anArray, { self }
]

{ #category : '*Ume' }
SmallInteger >> mutateDictionary: dict [

	^ dict mutateIntroducing: self
]

{ #category : '*Ume' }
SmallInteger >> mutateInteger: integer [

	^ self + integer 
]

{ #category : '*Ume' }
SmallInteger >> mutateJson: anotherJson [

	^ anotherJson mutateInteger: self
]

{ #category : '*Ume' }
SmallInteger >> mutateString: string [

	^ self 
]
