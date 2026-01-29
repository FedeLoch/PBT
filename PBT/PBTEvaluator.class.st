Class {
	#name : 'PBTEvaluator',
	#superclass : 'Object',
	#instVars : [
		'analyzer',
		'targetClasses'
	],
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'as yet unclassified' }
PBTEvaluator >> allocatedMemory [

	^ Smalltalk vm getParameters at: 34
]

{ #category : 'testing' }
PBTEvaluator >> analyzer [

	^ analyzer
]

{ #category : 'as yet unclassified' }
PBTEvaluator >> classesFor: target [

	targetClasses ifNil: [ targetClasses := target package definedClasses ].
	
	^ targetClasses
]

{ #category : 'as yet unclassified' }
PBTEvaluator >> eval: receiver method: target from: schema with: args andCoverage: incrCoverage collectingWith: collector [

	| localCoverageResult result assertResult case profilingResult |
	
	[
		"Reset the coverage result to avoid interference between tests"
		collector resetResult.
		
		"Executing PB Analyzer"
		case := PBAProgram from:
			[ result := receiver perform: target selector withArguments: args ] forClasses: (self classesFor: target).

		profilingResult := analyzer analyze: case.

		localCoverageResult := collector collectResult.
		
		assertResult := schema assert value: receiver value: args value: result
	] on: Error do: [ :error | ^ PBTEvalError new
			stack: (error signalerContext stackOfSize: 10);
			profilingResult: profilingResult;
			coverageResult: localCoverageResult;
			message: error messageText
	].

	^ (assertResult ifTrue: [ PBTEvalSuccess ] ifFalse: [ PBTEvalFail ]) new
		  callResult: result;
		  profilingResult: profilingResult;
		  coverageResult: localCoverageResult
]

{ #category : 'as yet unclassified' }
PBTEvaluator >> executionTimeProfiler [

	^ PBACallBacksProfiler new measuringOnlyExecutionTime
]

{ #category : 'initialization' }
PBTEvaluator >> initialize [

	super initialize.
	analyzer := PBAnalyzer new.
	self profilingByMethodCalls. "by default it profile only method calls and execution time"
]

{ #category : 'initialization' }
PBTEvaluator >> profilingByAllocatedMemory [

	analyzer profilers: { self executionTimeProfiler . PBAIllimaniProfiler new }
]

{ #category : 'as yet unclassified' }
PBTEvaluator >> profilingByBytecodes [

	analyzer profilers: { self executionTimeProfiler . PBABytecodeProfiler new }
]

{ #category : 'as yet unclassified' }
PBTEvaluator >> profilingByCoverage [

	analyzer profilers: { self executionTimeProfiler . PBACoverageCollectorProfiler new }
]

{ #category : 'as yet unclassified' }
PBTEvaluator >> profilingByExecutionTime [

	analyzer profilers: { self executionTimeProfiler }
]

{ #category : 'initialization' }
PBTEvaluator >> profilingByMethodCalls [

	analyzer profilers: {
			self executionTimeProfiler.
			PBAMethodProfiler new
	}
]

{ #category : 'initialization' }
PBTEvaluator >> profilingByScore [

	self profilingByExecutionTime 
]
