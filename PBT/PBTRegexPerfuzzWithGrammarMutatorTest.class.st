Class {
	#name : 'PBTRegexPerfuzzWithGrammarMutatorTest',
	#superclass : 'PBTRegexTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTRegexPerfuzzWithGrammarMutatorTest >> regexConstraint [

	^ PBTObjectConstraint new generator:
		  (PBTCorpusGenerator new
			   seedGenerator: (PBTGrammarGenerator new
					    grammar: GncRegexGrammar new;
					    maxHeight: 100;
					    maxSize: 100);
			   mutationsPerIteration: 3;
			   mutators: {
					(PBTGrammarLiteralsMutator from: GncRegexGrammar new) maxInputSize: 40
				};
			   heuristic: PBTPickBestElementDifferenceHeuristic new)
]

{ #category : 'running' }
PBTRegexPerfuzzWithGrammarMutatorTest >> setUp [
	
	super setUp.
	schema score: nil.
	runner := PBTRunner test: RxMatcher >> #matches: from: schema for: 5 minutes.
]

{ #category : 'tests' }
PBTRegexPerfuzzWithGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	
	1 halt.
]
