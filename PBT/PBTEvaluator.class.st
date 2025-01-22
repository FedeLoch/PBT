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

	| localCoverageResult callResult assertResult allocatedMemory |
	[
	allocatedMemory := self allocatedMemory.
	
	"Reset the coverage result to avoid interference between tests"
	collector resetResult.
	callResult := receiver perform: target selector withArguments: args.
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
				  message: error messageText ].

	^ (assertResult
		   ifTrue: [ PBTEvalSuccess ]
		   ifFalse: [ PBTEvalFail ]) new
		  callResult: callResult;
		  allocatedMemory: allocatedMemory;
		  coverageResult: localCoverageResult
]
