Extension { #name : 'RxMatcher' }

{ #category : '*PBT' }
RxMatcher >> asString [ 

	^ asString
]

{ #category : '*PBT' }
RxMatcher class >> fromSton: stonReader [

	| representation |
	representation := stonReader parseMapOrListRepresentation.
	^ representation first asRegex
]

{ #category : '*PBT' }
RxMatcher class >> invertOptionalByStarts: stringRegex [
	
	| expr |
	
	expr := stringRegex copyReplaceAll: '?' with: '*'.
	
	^ (self isValid: expr) ifTrue: [ expr ] ifFalse: [ stringRegex ]
]

{ #category : '*PBT' }
RxMatcher class >> invertPlusByStarts: stringRegex [

	| expr |
	
	expr := stringRegex copyReplaceAll: '+' with: '*'.
	
	^ (self isValid: expr) ifTrue: [ expr ] ifFalse: [ stringRegex ]

]

{ #category : '*PBT' }
RxMatcher class >> invertStarsByPlus: stringRegex [

	| expr |
	
	expr := stringRegex copyReplaceAll: '*' with: '+'.
	
	^ (self isValid: expr) ifTrue: [ expr ] ifFalse: [ stringRegex ]

]

{ #category : '*PBT' }
RxMatcher class >> isValid: stringRegex [

	[ stringRegex asRegex ] on: Error do: [ ^ false ].

	^ true

	
]

{ #category : '*PBT' }
RxMatcher class >> mutate: stringRegex [

	| result |
	result := nil.

	[result] whileNil: [
		[
		| copied at valueToInsert |
		copied := stringRegex deepCopy.
		at := (1 to: copied size) atRandom.
		valueToInsert := { $a. $b. $c. $+. $*. $? } atRandom.
"		at := ({ '('. ')' } includes: (copied at: at))
			      ifTrue: [ at + 1 ]
			      ifFalse: [ at ]."
		copied at: at put: valueToInsert asCharacter.
		copied asRegex.
		result := copied ]
			on: Error
			do: [  ] ].

	^ result
]

{ #category : '*PBT' }
RxMatcher class >> mutateCharacter: stringRegex using: otherString [

	| result |
	result := nil.

	[result] whileNil: [
		[
		| copied at valueToInsert |
		copied := stringRegex deepCopy.
		at := (1 to: copied size) atRandom.
		valueToInsert := otherString atRandom.
		copied at: at put: valueToInsert asCharacter.
		copied asRegex.
		result := copied ]
			on: Error
			do: [  ] ].

	^ result
]

{ #category : '*PBT' }
RxMatcher class >> mutateCharacter: stringRegex using: otherString times: n [

	| current |
	
	current := stringRegex.
	n timesRepeat: [ current := self mutateCharacter: current using: otherString ].

	^ current
]

{ #category : '*PBT' }
RxMatcher >> score [

	| input minRegex score1 score2 baseTime |

	input := asString minimalStringMatching.
	minRegex := input asRegex.
	
	baseTime := Smalltalk highResClock.
	self matches: input.
	score1 := Smalltalk highResClock - baseTime.
	
	baseTime := Smalltalk highResClock.
	minRegex matches: input.
	score2 := Smalltalk highResClock - baseTime.
	
	^ (score1 / (score2 max: 1)) asFloat
]

{ #category : '*PBT' }
RxMatcher class >> shiftUntilValid: stringRegex [

	| result shifted |
	result := nil.
	shifted := stringRegex.
	
	[result] whileNil: [ [
		shifted := shifted allButFirst, shifted first asString.
		shifted asRegex.
		result := shifted 
	] on: Error
			do: [  ] ].

	^ result


]

{ #category : '*PBT' }
RxMatcher >> stonContainSubObjects [
	^ false
]

{ #category : '*PBT' }
RxMatcher >> stonOn: stonWriter [
	"Use a hex representation"

	stonWriter writeObject: self listSingleton: self asString
]

{ #category : '*PBT' }
RxMatcher >> string: aString [

	asString := aString
]
