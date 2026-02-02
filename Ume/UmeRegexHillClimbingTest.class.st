Class {
	#name : 'UmeRegexHillClimbingTest',
	#superclass : 'UmeRegexTest',
	#instVars : [
		'regexGenerator'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'tests' }
UmeRegexHillClimbingTest >> regexConstraint [


	| randomGenerator |
	randomGenerator := UmeObjectConstraint new
		  objectClass: String;
		  generator: (UmeGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100).

	regexGenerator := UmeGenerator base: [ | re |
		re := randomGenerator gen.
		[ re size = 40 ] whileFalse: [ re := randomGenerator gen ].
		re ] mutating: [ :regexString :constraint :feedback | RxMatcher mutateCharacter: regexString using: randomGenerator gen ].

	^ UmeObjectConstraint new generator: regexGenerator
]

{ #category : 'tests' }
UmeRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemory [

	| result |
	
	result := (UmeRunner test: RxMatcher >> #matches: from: schema times: 1000) guidedByAllocatedMemory; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByAllocatedMemoryByTime [

	| result |
	
	result := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByAllocatedMemory; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByCoverage [

	| result |
	
	result := (UmeRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByCoverage; run.

	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByCoverageByTime [

	| result |
	
	result := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByCoverage; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByExecutionTime [

	| result |
	
	result := (UmeRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByExecutionTime; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedByExecutionTimeByTime [

	| result |
	
	result := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByExecutionTime; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedScore [

	| result |

	result := (UmeRunner test: RxMatcher >> #matches: from: schema times: 10000) guidedByScore; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedScoreByTime [

	| result |
	
	result := (UmeRunner test: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByScore; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBugGuidedScoreByTimeWithShallow [

	| result |
	
	result := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 1 minutes) guidedByScore; run.
	
	self assert: (result tests size) equals: 10000.

]

{ #category : 'tests' }
UmeRegexHillClimbingTest >> testGuidedByMethodsCalled [

	| result |

	result := (UmeRunner testWithLowCost: RxMatcher >> #matches: from: schema for: 10 minutes) guidedByMethodsCalls; run.
	
	self assert: (result tests size) equals: 10000.

]
