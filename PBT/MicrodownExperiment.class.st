Class {
	#name : 'MicrodownExperiment',
	#superclass : 'GrammarBasePathologicalBugMutatorExperiment',
	#category : 'PBT-Paper Experimentation',
	#package : 'PBT',
	#tag : 'Paper Experimentation'
}

{ #category : 'running' }
MicrodownExperiment >> maxInputSize [

	^ 200
]

{ #category : 'running' }
MicrodownExperiment >> name [

	^ 'Microdown'
]

{ #category : 'running' }
MicrodownExperiment >> newGrammar [

	^ ExtendedMarkdownGrammar new
]

{ #category : 'running' }
MicrodownExperiment >> schema: seed mutators: mutators mutationsPerIteration: n [

	| markdownGenerator |
	
	markdownGenerator := PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: seed);
		  mutationsPerIteration: n;
		  mutators: mutators;
		  heuristic: PBTPickBestElementDifferenceHeuristic new.

	^ PBTSchema new
		  receiverConstraint: (PBTObjectConstraint new generator: (PBTConstantGenerator new value: Microdown));
		  argumentConstraints: { (PBTObjectConstraint new objectClass: String; generator: markdownGenerator) };
		  assert: [ :regex :input :result | true ]
]

{ #category : 'running' }
MicrodownExperiment >> seeds [

	^ { 'a' . '# Header
	** This is a line comment **
	
	```
	code
	```
   
   	![Pharo is cool](http://pharo.org)
	
   	- list
   	1. ordered list 

  	`in text` and for Pharo hyperlinks to class, method and package: 
  	`Point`, `Point class`, `Point>>#setX:setY:`, `#’Microdown-Tests’`

  	References: @ref@' }
]

{ #category : 'running' }
MicrodownExperiment >> targetMethod [

	^ Microdown class >> #parse:
]
