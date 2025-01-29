Extension { #name : 'RxMatcher' }

{ #category : '*PBT' }
RxMatcher >> asString [ 

	^ asString 
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
RxMatcher class >> mutate: stringRegex using: otherString [

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
RxMatcher >> score [

	| input score1 score2 |

	input := asString minimalStringMatching.
	score1 := [ self matches: input ] timeToRunWithoutGC.
	score2 := [ input asRegex matches: input ] timeToRunWithoutGC.
	
	^ score1 / (score2 max: 1)
]

{ #category : '*PBT' }
RxMatcher >> string: aString [

	asString := aString
]
