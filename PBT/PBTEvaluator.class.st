Class {
	#name : 'PBTEvaluator',
	#superclass : 'Object',
	#instVars : [
		'collectors'
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
PBTEvaluator >> analyzedMethods: target [
	
	"target selfReachableMethods" "32, 5, 2, 3" 
	"target package methods" "573, 694, 163, 1807"
	"target sendReachableMethods" "573, 694, 99, 1807"

	^ target selfReachableMethods
]

{ #category : 'as yet unclassified' }
PBTEvaluator >> collector: target [

	| key |
	
	key := target name asString.
	collectors at: key ifAbsentPut: [ CoverageCollector new methods: (self analyzedMethods: target) ].

	^ collectors at: key
]

{ #category : 'as yet unclassified' }
PBTEvaluator >> eval: object method: target from: schema with: args andCoverage: incrCoverage [

	| localCoverageResult callResult assertResult allocatedMemory |
	[
	localCoverageResult := (self collector: target) runOn: [
		                       allocatedMemory := self allocatedMemory.
		                       callResult := object
			                                     perform: target selector
			                                     withArguments: args ].
									  allocatedMemory := self allocatedMemory - allocatedMemory.
	assertResult := schema assert
		                value: object
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

{ #category : 'as yet unclassified' }
PBTEvaluator >> initialize [ 

	super initialize.
	collectors := IdentityDictionary new.
]
