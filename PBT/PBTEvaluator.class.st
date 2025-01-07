Class {
	#name : 'PBTEvaluator',
	#superclass : 'Object',
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'as yet unclassified' }
PBTEvaluator >> eval: object method: target from: schema with: args [

	| coverageResult callResult assertResult |
	
	coverageResult := (CoverageCollector new methods: { target }) runOn: [
		callResult := object withArgs: args executeMethod: target.
	 ].
	
	[ assertResult := schema assert value: object value: args value: callResult ] on: Error do: [ :error |
		^ PBTEvalError new stack: error signalerContext shortDebugStack
	].

	^  (assertResult ifTrue: [ PBTEvalSuccess ] ifFalse: [ PBTEvalFail ]) new callResult: callResult; coverageResult: coverageResult
]
