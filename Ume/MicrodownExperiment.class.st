Class {
	#name : 'MicrodownExperiment',
	#superclass : 'GrammarBasePathologicalBugMutatorPaperExperiment',
	#category : 'Ume-Paper Experimentation',
	#package : 'Ume',
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
MicrodownExperiment >> schemaCorpusWith: mutators [

	| markdownGenerator |
	
	markdownGenerator := UmeCorpusGenerator new
		  seeds: self seeds deepCopy;
		  mutationsPerIteration: self mpi;
		  mutators: mutators;
		  heuristic: UmePickBestElementDifferenceHeuristic new.

	^ UmeSchema new
		  receiverConstraint: (UmeObjectConstraint new generator: (UmeConstantGenerator new value: Microdown));
		  argumentConstraints: { (UmeObjectConstraint new objectClass: String; generator: markdownGenerator) };
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

{ #category : 'running' }
MicrodownExperiment >> weightedGrammarSchema [

	| markdownGenerator |
	
	markdownGenerator := UmeGrammarGenerator new grammar: self newGrammar; maxSize: self maxInputSize.

	^ UmeSchema new
		  receiverConstraint: (UmeObjectConstraint new generator: (UmeConstantGenerator new value: Microdown));
		  argumentConstraints: { (UmeObjectConstraint new objectClass: String; generator: markdownGenerator) };
		  assert: [ :regex :input :result | true ]
]
