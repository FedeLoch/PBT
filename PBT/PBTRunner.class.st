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
PBTRunner class >> test: targetMethod [
	
	^ self test: targetMethod from: PBTSchema new
]

{ #category : 'tests' }
PBTRunner class >> test: targetMethod from: schema [
	
	^ self new schema: (PBTSchemaInfer enrich: schema for: targetMethod); target: targetMethod; test
]

{ #category : 'tests' }
PBTRunner class >> test: targetMethod from: schema for: time [

	^ self new
		schema: (PBTSchemaInfer enrich: schema for: targetMethod);
		withCriteria: (PBTTimeCriteria new timeout: time);
		target: targetMethod; test
]

{ #category : 'tests' }
PBTRunner class >> test: targetMethod from: schema times: times [

	^ self new
		schema: (PBTSchemaInfer enrich: schema for: targetMethod);
		withCriteria: (PBTCountCriteria new times: times);
		target: targetMethod; test
]

{ #category : 'tests' }
PBTRunner >> genReport: tests since: time withCoverage: totalCoverageResult [

	^ PBTResult resultFrom: tests since: time withCoverage: totalCoverageResult
]

{ #category : 'tests' }
PBTRunner >> genTest: incrCoverage [

	| arguments receiver testResult time |
	
	"Setup based on the enriched schema"
	receiver := generator genObjectFor: target from: schema.
	arguments := generator genInputsFor: target from: schema.
	
	"Target call and eval result"
	time := [
		testResult := evaluator eval: receiver method: target from: schema with: arguments andCoverage: incrCoverage
		] timeToRun.
	
	"Generate Test case"
	^ PBTTest new target: target;
		arguments: arguments;
		object: receiver;
		time: time;
		result: testResult
		
]

{ #category : 'tests' }
PBTRunner >> initialize [ 
	super initialize.
	evaluator := PBTEvaluator new.
	generator := PBTInputGenerator new.
	stopCriteria := PBTCountCriteria new times: 100.
	
	
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

	| tests time incrCoverage |
	
	time := Time millisecondClockValue.
	tests := OrderedCollection new.
	incrCoverage := IncrementalCoverageResult for: { target }.
	[self shouldGenNext: tests since: time] whileTrue: [ tests add: (self genTest: incrCoverage) ].

	^ self genReport: tests since: time withCoverage: incrCoverage
]

{ #category : 'tests' }
PBTRunner >> withCriteria: aCriteria [

	stopCriteria := aCriteria 
]
