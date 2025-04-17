Class {
	#name : 'PBTREEPerformanceMutantExperiment',
	#superclass : 'PBTRandomREExperiment',
	#instVars : [
		'mutants',
		'baseline',
		'threshold'
	],
	#category : 'PBT-BugDetection',
	#package : 'PBT',
	#tag : 'BugDetection'
}

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment class >> analyze [

	^ self new time: 1 seconds; analyze
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment class >> performExperimentsWithTimes: times [

	^ times collect: [ :time | self new time: time; analyze ]
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment class >> performExperimentsWithTimes: times threshold: aThreshold [

	^ times collect: [ :time | self new time: time; threshold: aThreshold; analyze ]
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> analyze [

	"Given a sensitivity level T,
		1 - We generate a base sample of N inputs.
		2 - We generate a box plot for each result.
		3 - Per each Mutant m_i, we install it
			3.1 - Per each config c_j, we generate N inputs ( MM )
			3.2 - We compare each MM_k with respect to the boxplot and we select the outliers number for m_i
			3.3 - We save the amount of outliers who identified the effect of m_i"
	| title |
	pbtConfigurations := self pbtConfigurations.
	baseline := self baseLinePbtConfiguration run.
	title := 'Result running ', self time humanReadablePrintString, ' each configuration '. 

	^ mutants inject: (PBTAnalysisResult new threshold: threshold; baseline: baseline; title: title) into: [ :result :mutant |
		mutant install.
		pbtConfigurations do: [ :config |
			result add: config run called: config title forMutant: mutant.
		].
		mutant uninstall.
		result.
	]
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> baseLinePbtConfiguration [

	^ self
		  executionConfig:
		  (self schemaWith: self simpleRegexConfig)
		  called: 'Baseline'
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> initialize [ 

	mutants := self mutants.
	threshold := 20 percent.
	
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> mutants [

	^ (MTManualMutatedMethodGenerationStrategy new targetMethods:
		   self target sendReachableMethods) mutationsFor:
		  PBTPerformanceOperations
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> simpleRegexConfig [

	^ PBTObjectConstraint new generator:
		  (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100)
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> threshold [

	^ threshold
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> threshold: aThreshold [

	threshold := aThreshold
]
