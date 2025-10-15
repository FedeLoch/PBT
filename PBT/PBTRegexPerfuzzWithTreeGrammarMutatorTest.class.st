Class {
	#name : 'PBTRegexPerfuzzWithTreeGrammarMutatorTest',
	#superclass : 'PBTRegexTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexPerfuzzWithTreeGrammarMutatorTest >> regexConstraint [

	^ PBTObjectConstraint new generator:
		  (PBTCorpusWithMutationsGenerator new
			   seedGenerator: (PBTGrammarGenerator new
					    grammar: GncRegexGrammar new;
					    maxHeight: 100;
					    maxSize: 100);
			   mutationsPerIteration: 1;
			   mutators: {
					(PBTTreeGrammarMutator from: GncRegexGrammar new mutationProbability: 10) maxInputSize: 41
				};
			   heuristic: PBTPickBestElementDifferenceHeuristic new)
]

{ #category : 'running' }
PBTRegexPerfuzzWithTreeGrammarMutatorTest >> setUp [
	
	super setUp.
	schema score: nil.
	runner := PBTRunner test: RxMatcher >> #matches: from: schema for: 2 minutes.
]

{ #category : 'tests' }
PBTRegexPerfuzzWithTreeGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	
	1 halt.
]
