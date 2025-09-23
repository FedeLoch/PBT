Class {
	#name : 'PBTRegexBugExperimentHillClimbingAndOptionalGenTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#instVars : [
		'regexGenerator'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexBugExperimentHillClimbingAndOptionalGenTest >> regexConstraint [


	| randomGenerator mutationGeneration |
	randomGenerator := PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100).
		
	mutationGeneration := PBTDyncamicSelectionGenerator new generators: {
		"Array of Mutators constant generators"
		PBTGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher mutateCharacter: regex using: randomGenerator gen ]). "Basic one mutating a random character"
		PBTGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher mutateCharacter: regex using: randomGenerator gen times: (2 to: 10) atRandom ]).
		PBTGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher invertOptionalByStarts: regex ]).
		PBTGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher invertPlusByStarts: regex ]).
		PBTGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher invertStarsByPlus: regex ]).
		PBTGenerator always: (PBTMutator mutate: [ :regex  | RxMatcher shiftUntilValid: regex ])
	}.

	regexGenerator := PBTGenerator base: [ | re |
		re := randomGenerator gen.
		[ re size = 40 ] whileFalse: [ re := randomGenerator gen ].
		re ] mutating: [ :regexString :constraint :feedback | (mutationGeneration gen: constraint by: feedback) mutate: regexString ].

	^ PBTObjectConstraint new generator: regexGenerator
]

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingAndOptionalGenTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedScoreByTimeWithShallow [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByScore; run.
	
	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingAndOptionalGenTest >> testGuidingByMethodsCalls [

	| pbtResult |

	pbtResult := (PBTRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 2 minutes) guidedByMethodsCalls; run.
	
	self assert: (pbtResult tests size) equals: 1000.

]
