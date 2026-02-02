Class {
	#name : 'MicrodownPerfMetricsExperiment',
	#superclass : 'PerformanceMetricsPaperExperiment',
	#category : 'Ume-Paper Experimentation',
	#package : 'Ume',
	#tag : 'Paper Experimentation'
}

{ #category : 'running' }
MicrodownPerfMetricsExperiment >> libraryName [

	^ 'Microdown'
]

{ #category : 'running' }
MicrodownPerfMetricsExperiment >> maxSize [

	^ 200
]

{ #category : 'running' }
MicrodownPerfMetricsExperiment >> newGrammar [

	^ ExtendedMarkdownGrammar new
]

{ #category : 'running' }
MicrodownPerfMetricsExperiment >> schema [

	| markdownGenerator |
	
	markdownGenerator := UmeCorpusGenerator new
		  seedGenerator: (UmeConstantGenerator new value: self seed);
		  mutationsPerIteration: self mpi;
		  mutators: self mutators;
		  heuristic: UmePickBestElementDifferenceHeuristic new.

	^ UmeSchema new
		  receiverConstraint: (UmeObjectConstraint new generator: (UmeConstantGenerator new value: Microdown));
		  argumentConstraints: { (UmeObjectConstraint new objectClass: String; generator: markdownGenerator) };
		  assert: [ :regex :input :result | true ]
]

{ #category : 'accessing' }
MicrodownPerfMetricsExperiment >> seed [

	^ '# Header
	** This is a line comment **
	
	```
	code
	```
   
   	![Pharo is cool](http://pharo.org)
	
   	- list
   	1. ordered list 

  	`in text` and for Pharo hyperlinks to class, method and package: 
  	`Point`, `Point class`, `Point>>#setX:setY:`, `#’Microdown-Tests’`

  	References: @ref@'
]

{ #category : 'running' }
MicrodownPerfMetricsExperiment >> targetMethod [

	^ Microdown class >> #parse:
]
