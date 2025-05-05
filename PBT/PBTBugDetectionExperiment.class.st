Class {
	#name : 'PBTBugDetectionExperiment',
	#superclass : 'Object',
	#instVars : [
		'pbtTests',
		'pbtConfigurations',
		'countOfCases'
	],
	#category : 'PBT-Experimentation',
	#package : 'PBT',
	#tag : 'Experimentation'
}

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment class >> analyze [

	^ self new analyze
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> analyze [

	| analysis |
	analysis := MTAnalysis new
		            classesToMutate: self classesToMutate;
		            mutantGenerationStrategy:
			            (MTManualMutatedMethodGenerationStrategy new
				             targetMethods: self target sendReachableMethods);
		            mutantSelectionStrategy:
			            MTRandomMethodMutantSelectionStrategy new.

	^ pbtConfigurations inject: Dictionary new into: [ :dict :config |
		  analysis testCases: config tests first testCase tests.
		  analysis run.
		  dict at: config title put: analysis generalResult.
		  dict ]
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> classesToMutate [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> countOfCases [

	^ countOfCases
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> countOfCases: anAmount [

	countOfCases := anAmount 
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> executionConfig: schema called: title [

	schema guidedByExecutionTime.
	^ PBTExperimentConfig new schema: schema; title: title; cases: self countOfCases; time: self time; target: self target
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
