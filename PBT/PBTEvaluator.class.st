Class {
	#name : 'PBTEvaluator',
	#superclass : 'Object',
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'as yet unclassified' }
PBTEvaluator >> eval: object method: target from: schema with: args andCoverage: incrCoverage [

	| localCoverageResult callResult assertResult |
	
	localCoverageResult := (CoverageCollector new methods: target selfReachableMethods) runOn: [
		callResult := object perform: target selector withArguments: args.
	].

	incrCoverage incrementWith: localCoverageResult.
	
	[ assertResult := schema assert value: object value: args value: callResult ] on: Error do: [ :error |
		^ PBTEvalError new stack: error signalerContext shortDebugStack
	].

	^  (assertResult ifTrue: [ PBTEvalSuccess ] ifFalse: [ PBTEvalFail ]) new callResult: callResult; coverageResult: localCoverageResult
]
