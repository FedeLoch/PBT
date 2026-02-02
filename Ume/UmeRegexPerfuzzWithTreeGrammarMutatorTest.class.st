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

	^ UmeObjectConstraint new
		unwrap: [ :case | (case class = UmeRegex) ifTrue: [ case regexString ] ifFalse: [ case ] ];
		generator: (UmeCorpusGenerator new
			   seeds: { self seed };
			   mutationsPerIteration: 3;
			   mutators: {
					(UmeGrammarDerivationMutator from: GncRegexGrammar new) maxInputSize: 41.
				};
			   heuristic: UmePickBestElementDifferenceHeuristic new)
]

{ #category : 'running' }
UmeRegexPerfuzzWithTreeGrammarMutatorTest >> setUp [
	
	super setUp.
	schema score: nil.
	runner := UmeRunner test: RxMatcher >> #matches: from: schema for: 4 hours.
]

{ #category : 'tests' }
UmeRegexPerfuzzWithTreeGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	
	1 halt.
]
