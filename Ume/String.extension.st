Extension { #name : 'String' }

{ #category : '*Ume' }
String >> asRegex [
	"Compile the receiver as a regex matcher. May raise RxParser>>syntaxErrorSignal
	or RxParser>>compilationErrorSignal.
	This is a part of the Regular Expression Matcher package, (c) 1996, 1999 Vassili Bykov.
	Refer to `documentation' protocol of RxParser class for details."

	^(RxParser preferredMatcherClass for: (RxParser new parse: self))
]

{ #category : '*Ume' }
String >> minimalStringMatching [

    ^ (RxParser parse: self) minimalString
]

{ #category : '*Ume' }
String >> mutateArray: anArray [

	^ anArray, { self }
]

{ #category : '*Ume' }
String >> mutateDictionary: dict [

	^ dict mutateIntroducing: self
]

{ #category : '*Ume' }
String >> mutateInteger: integer [

	^ self
]

{ #category : '*Ume' }
String >> mutateJson: json [
	
	json ifNil: [ ^ self ].
	
	^ json mutateString: self
]

{ #category : '*Ume' }
String >> mutateString: string [

	^ self, string
]
