Class {
	#name : 'PBTRunner',
	#superclass : 'Object',
	#instVars : [
		'target',
		'stopCriteria',
		'evaluator',
		'generator',
		'schema',
		'lastFeedback',
		'methodsToInstrument'
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
PBTRunner class >> test: targetMethod from: schema withCoverageTolerance: tolerance [

	^ self new
		schema: (PBTSchemaInfer enrich: schema for: targetMethod);
		withCriteria: (PBTStopCoverageCriteria new tolerance: tolerance);
		target: targetMethod; test
]

{ #category : 'tests' }
PBTRunner class >> testWithLowCost: targetMethod from: schema [
	
	^ self new schema: (PBTSchemaInfer enrich: schema for: targetMethod); target: targetMethod; withLowCost; test
]

{ #category : 'tests' }
PBTRunner class >> testWithLowCost: targetMethod from: schema for: time [

	^ self new
		schema: (PBTSchemaInfer enrich: schema for: targetMethod);
		withCriteria: (PBTTimeCriteria new timeout: time);
		target: targetMethod;
		withLowCost; test
]

{ #category : 'tests' }
PBTRunner class >> testWithLowCost: targetMethod from: schema times: times [

	^ self new
		schema: (PBTSchemaInfer enrich: schema for: targetMethod);
		withCriteria: (PBTCountCriteria new times: times);
		target: targetMethod
		withLowCost; test
]

{ #category : 'tests' }
PBTRunner class >> testWithLowCost: targetMethod from: schema withCoverageTolerance: tolerance [

	^ self new
		schema: (PBTSchemaInfer enrich: schema for: targetMethod);
		withCriteria: (PBTStopCoverageCriteria new tolerance: tolerance);
		target: targetMethod;
		withLowCost; test
]

{ #category : 'tests' }
PBTRunner >> genReport: tests since: time withCoverage: totalCoverageResult [

	^ PBTResult resultFrom: tests since: time withCoverage: totalCoverageResult andSchema: schema
]

{ #category : 'tests' }
PBTRunner >> genTest: incrCoverage with: collector [

	| arguments receiver testResult score feedback test |
	
	"Setup based on the enriched schema"
	receiver := generator genReceiverFor: target from: schema.
	arguments := generator genArgumentsFor: target from: schema.
	
	"Target call and eval result"
	testResult := evaluator eval: receiver method: target from: schema with: arguments andCoverage: incrCoverage collectingWith: collector.
	
	"Score calculation"
	score := self scoreFor: receiver with: arguments and: testResult.

	"Increment Incremental Coverage"
	incrCoverage incrementWith: testResult coverageResult.

	"Generate Test case"
	test := PBTTest new target: target;
		arguments: arguments;
		receiver: receiver;
		score: score;
		result: testResult.
	
	"Feeds the generator with the test result"
	feedback := (schema feedbackEvaluator eval: test).
	feedback ifNil: [ 1 halt. ].
	generator feedback: feedback.
	test feedback: feedback.
	test assert: schema assert.
	
	^ test
]

{ #category : 'tests' }
PBTRunner >> initialize [ 
	super initialize.
	evaluator := PBTEvaluator new.
	generator := PBTInputGenerator new.
	stopCriteria := PBTCountCriteria new times: 100.
	
	
]

{ #category : 'tests' }
PBTRunner >> reachableMethods [

	^ methodsToInstrument reject: [ :method |
		  method pragmas anySatisfy: [ :pragma |
			  pragma selector = #noInstrumentation ] ]
]

{ #category : 'accessing' }
PBTRunner >> schema: propSchema [

	schema := propSchema
	
]

{ #category : 'tests' }
PBTRunner >> scoreFor: receiver with: arguments and: testResult [

	^ schema score ifNil: [ nil ] ifNotNil: [ schema score value: receiver value: arguments value: testResult ]
]

{ #category : 'tests' }
PBTRunner >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	^ stopCriteria shouldGenNext: currentTests since: (Time millisecondsSince: aTime) withCoverage: aCoverage
]

{ #category : 'accessing' }
PBTRunner >> target: targetMethod [

	"target selfReachableMethods <- all self called methods"

	"target package methods <- all package methods"

	"target sendReachableMethods <- all send called methods"
	
	target := targetMethod.
	methodsToInstrument := target sendReachableMethods.
	
]

{ #category : 'tests' }
PBTRunner >> test [

	| tests time collector incrCoverage |
	
	time := Time millisecondClockValue.
	tests := OrderedCollection new.
	collector := C2CoverageCollector new methods: self reachableMethods.
	incrCoverage := IncrementalCoverageResult for: { target } from: collector.
	
	collector runOn: [
		[
			self shouldGenNext: tests since: time withCoverage: incrCoverage] whileTrue: [
			tests add: (self genTest: incrCoverage with: collector).
		]
	].

	^ self genReport: tests since: time withCoverage: incrCoverage
]

{ #category : 'tests' }
PBTRunner >> withCriteria: aCriteria [

	stopCriteria := aCriteria 
]

{ #category : 'tests' }
PBTRunner >> withLowCost [

	methodsToInstrument := { target } "target selfReachableMethods"
]
