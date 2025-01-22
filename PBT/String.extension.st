Extension { #name : 'String' }

{ #category : '*PBT' }
String >> minimalStringMatching [

    ^ (RxParser parse: self) minimalString
]
