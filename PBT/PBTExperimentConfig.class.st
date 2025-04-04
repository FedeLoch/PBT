Class {
	#name : 'PBTExperimentConfig',
	#superclass : 'Object',
	#instVars : [
		'schema',
		'title',
		'tests',
		'target',
		'time',
		'pbtResult'
	],
	#category : 'PBT-BugDetection',
	#package : 'PBT',
	#tag : 'BugDetection'
}

{ #category : 'accessing' }
PBTExperimentConfig >> generateTests [

	pbtResult := self run.
	tests := {  pbtResult mutalkTest }.
	
]

{ #category : 'accessing' }
PBTExperimentConfig >> result [

	^ pbtResult
]

{ #category : 'accessing' }
PBTExperimentConfig >> run [

	^ PBTRunner testWithLowCost: target from: schema for: time
]

{ #category : 'accessing' }
PBTExperimentConfig >> schema [

	^ schema
]

{ #category : 'accessing' }
PBTExperimentConfig >> schema: anSchema [

	schema := anSchema 

]

{ #category : 'accessing' }
PBTExperimentConfig >> target: aTarget [

	target := aTarget 
]

{ #category : 'accessing' }
PBTExperimentConfig >> tests [
	
	^ tests
]

{ #category : 'accessing' }
PBTExperimentConfig >> time: aTime [

	time := aTime 
]

{ #category : 'accessing' }
PBTExperimentConfig >> title [

	^ title
]

{ #category : 'accessing' }
PBTExperimentConfig >> title: aTitle [ 
	
	title := aTitle
]
