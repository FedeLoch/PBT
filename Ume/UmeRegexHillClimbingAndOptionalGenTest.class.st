Class {
	#name : 'UmeRegexHillClimbingAndOptionalGenTest',
	#superclass : 'UmeRegexTest',
	#instVars : [
		'regexGenerator'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeRegexHillClimbingAndOptionalGenTest >> regexConstraint [

	| randomGenerator mutationGeneration |
	randomGenerator := PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100).
		
	mutationGeneration := PBTDyncamicSelectionGenerator new generators: {
		"Array of Mutators constant generators"
		UmeGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher mutateCharacter: regex using: randomGenerator gen ]). "Basic one mutating a random character"
		UmeGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher mutateCharacter: regex using: randomGenerator gen times: (2 to: 10) atRandom ]).
		UmeGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher invertOptionalByStarts: regex ]).
		UmeGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher invertPlusByStarts: regex ]).
		UmeGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher invertStarsByPlus: regex ]).
		UmeGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher shiftUntilValid: regex ])
	}.

	regexGenerator := UmeGenerator base: [ | re |
		re := randomGenerator gen.
		[ re size = 40 ] whileFalse: [ re := randomGenerator gen ].
		re ] mutating: [ :regexString :constraint :feedback |
			mutationGeneration feed: feedback.
			(mutationGeneration gen: constraint) mutate: regexString
		].

	^ PBTObjectConstraint new generator: regexGenerator
]

{ #category : 'tests' }
UmeRegexHillClimbingAndOptionalGenTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedScoreByTimeWithShallow [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexHillClimbingAndOptionalGenTest >> testGuidingByMethodsCalls [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 5 minutes) guidedByMethodsCalls; run.
	
	self assert: (pbtResult tests size) equals: 1000.

]
