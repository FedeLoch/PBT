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
