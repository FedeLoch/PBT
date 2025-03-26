Class {
	#name : 'PBTBugDetectionExperiment',
	#superclass : 'Object',
	#instVars : [
		'pbtTests',
		'pbtConfigurations'
	],
	#category : 'PBT-BugDetection',
	#package : 'PBT',
	#tag : 'BugDetection'
}

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment class >> bugDetectionAnalysis [

	^ self new bugDetectionAnalysis
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> analysisFrom: config withMutantGen: mutantGenerator [

	^ MTAnalysis new
		  classesToMutate: self classesToMutate;
		  mutantGenerationStrategy: mutantGenerator;
		  mutantSelectionStrategy: MTRandomMethodMutantSelectionStrategy new;
		  testClasses: config tests
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> bugDetectionAnalysis [

	| mutantGenerator |
	mutantGenerator := MTManualMutatedMethodGenerationStrategy new
		                   targetMethods: self target sendReachableMethods.
	1 halt.
	^ pbtConfigurations inject: Dictionary new into: [ :dict :config |
		  | analysis |
		  analysis := self
			              analysisFrom: config
			              withMutantGen: mutantGenerator.
		  analysis run.
		  dict at: config title put: analysis generalResult.
		  dict ]
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> classesToMutate [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> executionConfig: schema called: title [

	schema guidedByExecutionTime.
	^ PBTExperimentConfig new schema: schema; title: title; time: self time; target: self target
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> initialize [

	super initialize.
	pbtConfigurations := self pbtConfigurations.
	pbtConfigurations do: #generateTests
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> pbtConfigurations [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> target [

	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> time [

	self subclassResponsibility 
]
