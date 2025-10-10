Class {
	#name : 'PBTMicrodownPerfuzzWithGrammarMutatorTest',
	#superclass : 'PBTMicrodownTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTMicrodownPerfuzzWithGrammarMutatorTest >> markdownGenerator [

	| seed |
	
	seed := '
	# Header
        @anchor
	% This is a line comment

	```language=Pharo&caption=Beautiful&label=Fig1
   	code
	```
   
   	![Pharo is cool .%anchor=fig:pharo&width=80](http://pharo.org)
	
   	- list
   	1. ordered list 

  	`in text` and for Pharo hyperlinks to class, method and package: 
  	`Point`, `Point class`, `Point>>#setX:setY:`, `#’Microdown-Tests’ (for packages)

  	References: *@ref@*'.

	^ PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: seed);
		  mutationsPerIteration: 100;
		  mutators: {
				(PBTGrammarMutator from: ExtendedMarkdownGrammar new)
			};
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTMicrodownPerfuzzWithGrammarMutatorTest >> setUp [

	super setUp.
	runner := PBTRunner test: Microdown class >> #parse: from: schema for: 5 minutes.
]

{ #category : 'tests' }
PBTMicrodownPerfuzzWithGrammarMutatorTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
