Class {
	#name : 'PerformanceMetricsPaperExperiment',
	#superclass : 'Object',
	#instVars : [
		'experimentTime'
	],
	#category : 'PBT-Paper Experimentation',
	#package : 'PBT',
	#tag : 'Paper Experimentation'
}

{ #category : 'as yet unclassified' }
PerformanceMetricsPaperExperiment class >> getResults: sourcePath [
	
	| instance |
	
	instance := self new.
	^ { 'allocatedMemory' . 'codeCoverage' . 'bytecodes' . 'methodsCalls' } collect: [ :guidedBy | | file |
		file := instance libraryName, guidedBy, '.ston'.
		STON fromStream: (sourcePath, file) asFileReference readStream
	] 
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment class >> run [

	^ self new run
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> experimentTime [

	^ experimentTime
]

{ #category : 'initialization' }
PerformanceMetricsPaperExperiment >> initialize [ 

	super initialize.
	experimentTime := 1 hour"8 hours".
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> libraryName [

	self subclassResponsibility 
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> maxSize [

	self subclassResponsibility 
]

{ #category : 'accessing' }
PerformanceMetricsPaperExperiment >> mpi [

	^ 3
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> mutators [

	^ {
		(PBTGrammarMutator from: self newGrammar) maxInputSize: self maxSize.
		(PBTTreeGrammarMutator from: self newGrammar) maxInputSize: self maxSize
	}
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> newGrammar [

	self subclassResponsibility 
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> run [
	
	self runGuidingByAllocatedMemory.
	self runGuidingByCodeCoverage.
	self runGuidingByBytecodes.
	self runGuidingByMethodsCalled.
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> runGuidingBy: guidingBlock name: guidingStrategyName [
	
	| schema runner result fileName |
	
	Smalltalk garbageCollect. "We perform a garbageCollect before each execution"
	fileName := self libraryName, guidingStrategyName, '.ston'.
	
	schema := self schema.
	
	runner := PBTRunner test: self targetMethod from: schema for: self experimentTime.
	
	"Guided by current strategy"
	guidingBlock value: runner.
	
	result := runner run.
	
	result writeToFile: fileName.
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> runGuidingByAllocatedMemory [

	self runGuidingBy: #guidedByAllocatedMemory name: 'allocatedMemory'
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> runGuidingByBytecodes [

	self runGuidingBy: #guidedByBytecodes name: 'bytecodes'
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> runGuidingByCodeCoverage [

	self runGuidingBy: #guidedByCoverage name: 'codeCoverage'
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> runGuidingByMethodsCalled [

	self runGuidingBy: #guidedByMethodsCalls name: 'methodsCalls'
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> schema [

	self subclassResponsibility 
]

{ #category : 'accessing' }
PerformanceMetricsPaperExperiment >> seed [

	self subclassResponsibility 
]

{ #category : 'running' }
PerformanceMetricsPaperExperiment >> targetMethod [

	self subclassResponsibility 
]
