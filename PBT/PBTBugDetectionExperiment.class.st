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
PBTBugDetectionExperiment >> bugDetectionAnalysis [

	^ pbtTests collectWithIndex: [ :instanceTests :index |
		  | analysis |
		  analysis := MutationTestingAnalysis
			              testCasesFrom: instanceTests
			              mutating: self classesToMutate
			              using: MutantOperator contents
			              with: AllTestsMethodsRunningTestSelectionStrategy new.
		  analysis run.
		  { (pbtConfigurations at: index) title. analysis generalResult }
	]
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> classesToMutate [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> initialize [

	super initialize.
	pbtConfigurations := self pbtConfigurations.
	pbtTests := pbtConfigurations collect: [ :config |
		(PBTRunner testWithLowCost: config target from: config schema for: config time) mutalkTests
	]
]

{ #category : 'as yet unclassified' }
PBTBugDetectionExperiment >> pbtConfigurations [

	self subclassResponsibility
]
