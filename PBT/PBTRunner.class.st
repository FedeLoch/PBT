Class {
	#name : 'PBTRunner',
	#superclass : 'Object',
	#instVars : [
		'target',
		'stopCriteria',
		'evaluator',
		'generator',
		'schema'
	],
	#category : 'PBT-Runner',
	#package : 'PBT',
	#tag : 'Runner'
}

{ #category : 'tests' }
PBTRunner class >> test: targetMethod from: schema [
	
	^ self new schema: (PBTPropsInfer enrich: schema for: targetMethod); target: targetMethod; test
]

{ #category : 'tests' }
PBTRunner >> getReport: tests since: time [

	^ PBTResult resultFrom: tests since: time
]

{ #category : 'tests' }
PBTRunner >> getTest [

	| inputs object callResult testResult |
	
	"Setup based on the enriched schema"
	inputs := generator genInputsFor: target from: schema.
	object := generator genObjectFor: target from: schema.
	
	"Target call"
	callResult := object withArgs: inputs executeMethod: target.
	
	"Eval result"
	testResult := evaluator evalTest: callResult from: target.
	
	"Generate Test case"
	^ PBTTest new target: target;
		callInputs: inputs;
		objectInput: object;
		callResult: callResult;
		result: testResult
		
]

{ #category : 'tests' }
PBTRunner >> initialize [ 
	super initialize.
	evaluator := PBTEvaluator new.
	generator := PBTInputGenerator new.
	stopCriteria := PBTCountCriteria new times: 1000.
	
	
]

{ #category : 'accessing' }
PBTRunner >> schema: propSchema [

	schema := propSchema
	
]

{ #category : 'tests' }
PBTRunner >> shouldGenNext: currentTests since: aTime [

	^ stopCriteria shouldGenNext: currentTests since: (Time millisecondsSince: aTime)
]

{ #category : 'accessing' }
PBTRunner >> target: targetMethod [

	target := targetMethod
	
]

{ #category : 'tests' }
PBTRunner >> test [

	| tests time |
	
	time := Time microsecondClockValue.
	tests := OrderedCollection new.
	[self shouldGenNext: tests since: time] whileTrue: [ tests add: self getTest ].
	
	^ self getReport: tests since: time
]
