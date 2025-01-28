Class {
	#name : 'PBTEvaluator',
	#superclass : 'Object',
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

	| localCoverageResult callResult assertResult allocatedMemory time |
	[
	allocatedMemory := self allocatedMemory.

	"Reset the coverage result to avoid interference between tests"
	collector resetResult.

	time := Duration milliSeconds:
		        [
		        callResult := receiver
			                      perform: target selector
			                      withArguments: args ] timeToRunWithoutGC.

	localCoverageResult := collector collectResult.

	allocatedMemory := self allocatedMemory - allocatedMemory.
	assertResult := schema assert
		                value: receiver
		                value: args
		                value: callResult ]
		on: Error
		do: [ :error |
			^ PBTEvalError new
				  stack: (error signalerContext stackOfSize: 10);
				  allocatedMemory: allocatedMemory;
				  coverageResult: localCoverageResult;
				  time: time;
				  message: error messageText ].

	^ (assertResult
		   ifTrue: [ PBTEvalSuccess ]
		   ifFalse: [ PBTEvalFail ]) new
		  callResult: callResult;
		  time: time;
		  allocatedMemory: allocatedMemory;
		  coverageResult: localCoverageResult
]
