Class {
	#name : 'PBTRunner',
	#superclass : 'Object',
	#instVars : [
		'target',
		'stopCriteria',
		'evaluator',
		'generator',
		'schema',
		'lastFeedback'
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
PBTRunner >> genReport: tests since: time withCoverage: totalCoverageResult [

	^ PBTResult resultFrom: tests since: time withCoverage: totalCoverageResult
]

{ #category : 'tests' }
PBTRunner >> genTest: incrCoverage with: collector [

	| arguments receiver testResult time score |
	
	"Setup based on the enriched schema"
	receiver := generator genReceiverFor: target from: schema.
	arguments := generator genArgumentsFor: target from: schema.
	
	"Target call and eval result"
	time := [
		testResult := evaluator eval: receiver method: target from: schema with: arguments andCoverage: incrCoverage collectingWith: collector
	] timeToRun.

	"Feeds the generator with the test result"
	generator feedback: (incrCoverage increaseCoverage: testResult coverageResult).
	
	"Score calculation"
	score := self scoreFor: testResult.

	"Increment Incremental Coverage"
	incrCoverage incrementWith: testResult coverageResult.

	"Generate Test case"
	^ PBTTest new target: target;
		arguments: arguments;
		object: receiver;
		time: time;
		score: score;
		result: testResult		
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
	
	"target selfReachableMethods" "<- all self called methods"
	"target package methods" "<- all package methods"
	"target sendReachableMethods" "<- all send called methods"

	^ target sendReachableMethods
]

{ #category : 'accessing' }
PBTRunner >> schema: propSchema [

	schema := propSchema
	
]

{ #category : 'tests' }
PBTRunner >> scoreFor: testResult [

	^ schema score ifNil: [ nil ] ifNotNil: [ schema score value: testResult ]
]

{ #category : 'tests' }
PBTRunner >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	^ stopCriteria shouldGenNext: currentTests since: (Time millisecondsSince: aTime) withCoverage: aCoverage
]

{ #category : 'accessing' }
PBTRunner >> target: targetMethod [

	target := targetMethod
	
]

{ #category : 'tests' }
PBTRunner >> test [

	| tests time collector incrCoverage |
	
	time := Time millisecondClockValue.
	tests := OrderedCollection new.
	collector := C2CoverageCollector new methods: self reachableMethods.
	incrCoverage := IncrementalCoverageResult for: { target }.
	
	collector runOn: [
		[
			self shouldGenNext: tests since: time withCoverage: incrCoverage] whileTrue: [
			tests add: (self genTest: incrCoverage with: collector)
		]
	].

	^ self genReport: tests since: time withCoverage: incrCoverage
]

{ #category : 'tests' }
PBTRunner >> withCriteria: aCriteria [

	stopCriteria := aCriteria 
]
