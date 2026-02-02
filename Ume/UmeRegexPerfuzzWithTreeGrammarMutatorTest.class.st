Class {
	#name : 'UmeRegexPerfuzzWithTreeGrammarMutatorTest',
	#superclass : 'UmeRegexTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeRegexPerfuzzWithTreeGrammarMutatorTest >> regexConstraint [

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
UmeRegexPerfuzzWithTreeGrammarMutatorTest >> setUp [
	
	super setUp.
	schema score: nil.
	runner := PBTRunner test: RxMatcher >> #matches: from: schema for: 4 hours.
]

{ #category : 'tests' }
UmeRegexPerfuzzWithTreeGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	
	1 halt.
]
