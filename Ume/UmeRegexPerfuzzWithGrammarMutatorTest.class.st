Class {
	#name : 'UmeRegexPerfuzzWithGrammarMutatorTest',
	#superclass : 'UmeRegexTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeRegexPerfuzzWithGrammarMutatorTest >> regexConstraint [

	^ UmeObjectConstraint new generator:
		  (UmeCorpusGenerator new
			   seedGenerator: (PBTGrammarGenerator new
					    grammar: GncRegexGrammar new;
					    maxHeight: 100;
					    maxSize: 100);
			   mutationsPerIteration: 3;
			   mutators: {
					(UmeGrammarLiteralsMutator from: GncRegexGrammar new) maxInputSize: 40
				};
			   heuristic: UmePickBestElementDifferenceHeuristic new)
]

{ #category : 'running' }
UmeRegexPerfuzzWithGrammarMutatorTest >> setUp [
	
	super setUp.
	schema score: nil.
	runner := UmeRunner test: RxMatcher >> #matches: from: schema for: 5 minutes.
]

{ #category : 'tests' }
UmeRegexPerfuzzWithGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	
	1 halt.
]
