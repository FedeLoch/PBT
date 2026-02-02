Extension { #name : 'RxMatcher' }

{ #category : '*Ume' }
RxMatcher >> asString [ 

	^ asString
]

{ #category : '*Ume' }
RxMatcher class >> fromSton: stonReader [

	| representation |
	representation := stonReader parseMapOrListRepresentation.
	^ representation first asRegex
]

{ #category : '*Ume' }
RxMatcher class >> invertOptionalByStarts: stringRegex [
	
	| expr |
	
	expr := stringRegex copyReplaceAll: '?' with: '*'.
	
	^ (self isValid: expr) ifTrue: [ expr ] ifFalse: [ stringRegex ]
]

{ #category : '*Ume' }
RxMatcher class >> invertPlusByStarts: stringRegex [

	| expr |
	
	expr := stringRegex copyReplaceAll: '+' with: '*'.
	
	^ (self isValid: expr) ifTrue: [ expr ] ifFalse: [ stringRegex ]

]

{ #category : '*Ume' }
RxMatcher class >> invertStarsByPlus: stringRegex [

	| expr |
	
	expr := stringRegex copyReplaceAll: '*' with: '+'.
	
	^ (self isValid: expr) ifTrue: [ expr ] ifFalse: [ stringRegex ]

]

{ #category : '*Ume' }
RxMatcher class >> isValid: stringRegex [

	[ stringRegex asRegex ] on: Error do: [ ^ false ].

	^ true

	
]

{ #category : '*Ume' }
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

{ #category : '*Ume' }
RxMatcher class >> mutateCharacter: stringRegex using: otherString [

	| result target |
	target := stringRegex class = PBTRegex
		          ifTrue: [ stringRegex regexString ]
		          ifFalse: [ stringRegex ].

	result := nil.

	[ result ] whileNil: [
		[
		| copied at valueToInsert |
		copied := target copy.
		valueToInsert := otherString atRandom.
		at := (1 to: copied size) atRandom.
		copied size < 40
			ifTrue: [ copied := (copied copyFrom: 1  to: at), valueToInsert asString, (copied copyFrom: at to: copied size) ]
			ifFalse: [
				copied at: at put: valueToInsert asCharacter ].
		copied asRegex.
		result := copied ]
			on: Error
			do: [ :e | e class = RegexSyntaxError ifFalse: [ 1 halt ] ] ].

	^ result
]

{ #category : '*Ume' }
RxMatcher class >> mutateCharacter: stringRegex using: otherString times: n [

	| current |
	
	current := stringRegex.
	n timesRepeat: [ current := self mutateCharacter: current using: otherString ].

	^ current
]

{ #category : '*Ume' }
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

{ #category : '*Ume' }
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

{ #category : '*Ume' }
RxMatcher >> stonContainSubObjects [
	^ false
]

{ #category : '*Ume' }
RxMatcher >> stonOn: stonWriter [
	"Use a hex representation"

	stonWriter writeObject: self listSingleton: self asString
]

{ #category : '*Ume' }
RxMatcher >> string: aString [

	asString := aString
]
