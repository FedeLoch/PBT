Class {
	#name : 'PBTEvaluator',
	#superclass : 'Object',
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'as yet unclassified' }
PBTEvaluator >> analyzedMethods: target [
	
	"target selfReachableMethods" "32, 5, 2, 3" 
	"target package methods" "573, 694, 163, 1807"
	"target sendReachableMethods" "573, 694, 99, 1807"
	^ target selfReachableMethods
]

{ #category : 'as yet unclassified' }
PBTEvaluator >> eval: object method: target from: schema with: args andCoverage: incrCoverage [

	| localCoverageResult callResult assertResult |
	
	[
		localCoverageResult := (CoverageCollector new methods:
		                        (self analyzedMethods: target)) runOn: [
		                       callResult := object
			                                     perform: target selector
			                                     withArguments: args ].

		assertResult := schema assert
		                value: object
		                value: args
		                value: callResult
		
	] on: Error do: [ :error | ^ PBTEvalError new stack: (error signalerContext stackOfSize: 10); message: error messageText ].

	^ (assertResult
		   ifTrue: [ PBTEvalSuccess ]
		   ifFalse: [ PBTEvalFail ]) new
		  callResult: callResult;
		  coverageResult: localCoverageResult
]
