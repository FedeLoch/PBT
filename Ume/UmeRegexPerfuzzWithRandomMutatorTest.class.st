Class {
	#name : 'UmeRegexPerfuzzWithRandomMutatorTest',
	#superclass : 'UmeRegexTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeRegexPerfuzzWithRandomMutatorTest >> regexConstraint [

	^ PBTObjectConstraint new generator:
		  (PBTCorpusGenerator new
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
UmeRegexPerfuzzWithRandomMutatorTest >> setUp [
	
	super setUp.
	schema score: nil.
	runner := PBTRunner test: RxMatcher >> #matches: from: schema for: 2 minutes.
]

{ #category : 'tests' }
UmeRegexPerfuzzWithRandomMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	
	1 halt.
]
