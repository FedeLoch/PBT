Class {
	#name : 'PBTRegexPerfuzzWithTreeGrammarMutatorTest',
	#superclass : 'PBTRegexTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTRegexPerfuzzWithTreeGrammarMutatorTest >> regexConstraint [

	^ PBTObjectConstraint new
		unwrap: [ :case | (case class = PBTRegex) ifTrue: [ case regexString ] ifFalse: [ case ] ];
		generator: (PBTCorpusGenerator new
			   seeds: { self seed };
			   mutationsPerIteration: 3;
			   mutators: {
					(PBTGrammarDerivationMutator from: GncRegexGrammar new) maxInputSize: 41.
				};
			   heuristic: PBTPickBestElementDifferenceHeuristic new)
]

{ #category : 'running' }
PBTRegexPerfuzzWithTreeGrammarMutatorTest >> setUp [
	
	super setUp.
	schema score: nil.
	runner := PBTRunner test: RxMatcher >> #matches: from: schema for: 4 hours.
]

{ #category : 'tests' }
PBTRegexPerfuzzWithTreeGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	
	1 halt.
]
