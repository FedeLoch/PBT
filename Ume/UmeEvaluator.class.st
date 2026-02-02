Class {
	#name : 'UmeEvaluator',
	#superclass : 'Object',
	#instVars : [
		'analyzer',
		'targetClasses'
	],
	#category : 'Ume-Evaluation',
	#package : 'Ume',
	#tag : 'Evaluation'
}

{ #category : 'as yet unclassified' }
UmeEvaluator >> allocatedMemory [

	^ Smalltalk vm getParameters at: 34
]

{ #category : 'testing' }
UmeEvaluator >> analyzer [

	^ analyzer
]

{ #category : 'as yet unclassified' }
UmeEvaluator >> classesFor: target [

	targetClasses ifNil: [ targetClasses := target package definedClasses ].
	
	^ targetClasses
]

{ #category : 'as yet unclassified' }
UmeEvaluator >> eval: receiver method: target from: schema with: args andCoverage: incrCoverage collectingWith: collector [

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
	] on: Error do: [ :error | ^ UmeEvalError new
			stack: (error signalerContext stackOfSize: 10);
			profilingResult: profilingResult;
			coverageResult: localCoverageResult;
			message: error messageText
	].

	^ (assertResult ifTrue: [ UmeEvalSuccess ] ifFalse: [ UmeEvalFail ]) new
		  callResult: result;
		  profilingResult: profilingResult;
		  coverageResult: localCoverageResult
]

{ #category : 'as yet unclassified' }
UmeEvaluator >> executionTimeProfiler [

	^ PBACallBacksProfiler new measuringOnlyExecutionTime
]

{ #category : 'initialization' }
UmeEvaluator >> initialize [

	super initialize.
	analyzer := PBAnalyzer new.
	self profilingByMethodCalls. "by default it profile only method calls and execution time"
]

{ #category : 'initialization' }
UmeEvaluator >> profilingByAllocatedMemory [

	analyzer profilers: { self executionTimeProfiler . PBAIllimaniProfiler new }
]

{ #category : 'as yet unclassified' }
UmeEvaluator >> profilingByBytecodes [

	analyzer profilers: { self executionTimeProfiler . PBABytecodeProfiler new }
]

{ #category : 'as yet unclassified' }
UmeEvaluator >> profilingByCoverage [

	analyzer profilers: { self executionTimeProfiler . PBACoverageCollectorProfiler new }
]

{ #category : 'as yet unclassified' }
UmeEvaluator >> profilingByExecutionTime [

	analyzer profilers: { self executionTimeProfiler }
]

{ #category : 'initialization' }
UmeEvaluator >> profilingByMethodCalls [

	analyzer profilers: {
			self executionTimeProfiler.
			PBAMethodProfiler new
	}
]

{ #category : 'initialization' }
UmeEvaluator >> profilingByScore [

	self profilingByExecutionTime 
]
