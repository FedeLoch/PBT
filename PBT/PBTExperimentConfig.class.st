Class {
	#name : 'PBTExperimentConfig',
	#superclass : 'Object',
	#instVars : [
		'schema',
		'title',
		'tests',
		'target',
		'time',
		'pbtResult',
		'cases'
	],
	#category : 'PBT-Experimentation',
	#package : 'PBT',
	#tag : 'Experimentation'
}

{ #category : 'accessing' }
PBTExperimentConfig >> cases: amount [ 
	
	cases := amount
]

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

	^ time ifNil: [
		PBTRunner testWithLowCost: target from: schema times: cases
	] ifNotNil: [
		PBTRunner testWithLowCost: target from: schema for: time
	]
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
