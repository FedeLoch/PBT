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

	| arguments receiver testResult |
	
	"Setup based on the enriched schema"
	receiver := generator genObjectFor: target from: schema.
	arguments := generator genInputsFor: target from: schema.
	
	"Target call and eval result"
	testResult := evaluator eval: receiver method: target from: schema with: arguments andCoverage: incrCoverage.
	
	"Generate Test case"
	^ PBTTest new target: target;
		arguments: arguments;
		object: receiver;
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

	| tests time incrementalCoverage |
	
	time := Time millisecondClockValue.
	tests := OrderedCollection new.
	incrementalCoverage := IncrementalCoverageResult for: { target }.
	[self shouldGenNext: tests since: time] whileTrue: [ tests add: (self genTest: incrementalCoverage) ].

	^ self genReport: tests since: time withCoverage: incrementalCoverage
]

{ #category : 'tests' }
PBTRunner >> withCriteria: aCriteria [

	stopCriteria := aCriteria 
]
