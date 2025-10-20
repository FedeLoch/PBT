Class {
	#name : 'PBTRegexPerfuzzWithRandomMutatorTest',
	#superclass : 'PBTRegexTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTRegexPerfuzzWithRandomMutatorTest >> regexConstraint [

	^ PBTObjectConstraint new generator:
		  (PBTCorpusWithMutationsGenerator new
			   seedGenerator: (PBTGrammarGenerator new
					    grammar: GncRegexGrammar new;
					    maxHeight: 100;
					    maxSize: 100);
			   mutationsPerIteration: 1;
			   mutators: {
					   (PBTAddByteMutator new maxInputSize: 40).
					   PBTByteFlipMutator new.
					   PBTDelByteMutator new
				};
			   heuristic: PBTPickBestElementDifferenceHeuristic new)
]

{ #category : 'running' }
PBTRegexPerfuzzWithRandomMutatorTest >> setUp [
	
	super setUp.
	schema score: nil.
	runner := PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes.
]

{ #category : 'tests' }
PBTRegexPerfuzzWithRandomMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	
	1 halt.
]
