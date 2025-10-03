Extension { #name : 'String' }

{ #category : '*PBT' }
String >> asRegex [
	"Compile the receiver as a regex matcher. May raise RxParser>>syntaxErrorSignal
	or RxParser>>compilationErrorSignal.
	This is a part of the Regular Expression Matcher package, (c) 1996, 1999 Vassili Bykov.
	Refer to `documentation' protocol of RxParser class for details."

	^(RxParser preferredMatcherClass for: (RxParser new parse: self))
]

{ #category : '*PBT' }
String >> minimalStringMatching [

    ^ (RxParser parse: self) minimalString
]

{ #category : '*PBT' }
String >> mutateArray: anArray [

	^ anArray, { self }
]

{ #category : '*PBT' }
String >> mutateDictionary: dict [

	^ dict mutateIntroducing: self
]

{ #category : '*PBT' }
String >> mutateInteger: integer [

	^ self
]

{ #category : '*PBT' }
String >> mutateJson: json [
	
	json ifNil: [ ^ self ].
	
	^ json mutateString: self
]

{ #category : '*PBT' }
String >> mutateString: string [

	^ self, string
]
