Class {
	#name : 'PBTEvaluator',
	#superclass : 'Object',
	#instVars : [
		'analyzer'
	],
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'as yet unclassified' }
PBTEvaluator >> allocatedMemory [

	^ Smalltalk vm getParameters at: 34
]

{ #category : 'as yet unclassified' }
PBTEvaluator >> eval: receiver method: target from: schema with: args andCoverage: incrCoverage collectingWith: collector [

	| localCoverageResult result assertResult case profilingResult |
	
	[
		"Reset the coverage result to avoid interference between tests"
		collector resetResult.
		
		"Executing PB Analyzer"
		case := PBAProgram from: [ result := receiver perform: target selector withArguments: args ].
		profilingResult := analyzer analyze: case.
		
		localCoverageResult := collector collectResult.
		
		assertResult := schema assert value: receiver value: args value: result
	] on: Error do: [ :error | ^ PBTEvalError new
			stack: (error signalerContext stackOfSize: 10);
			coverageResult: localCoverageResult;
			message: error messageText
	].

	^ (assertResult ifTrue: [ PBTEvalSuccess ] ifFalse: [ PBTEvalFail ]) new
		  callResult: result;
		  profilingResult: profilingResult;
		  coverageResult: localCoverageResult
]

{ #category : 'initialization' }
PBTEvaluator >> initialize [

	super initialize.
	analyzer := PBAnalyzer new.
]
