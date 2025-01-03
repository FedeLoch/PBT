Class {
	#name : 'PBTTest',
	#superclass : 'Object',
	#instVars : [
		'target',
		'callInputs',
		'objectInput',
		'callResult',
		'result'
	],
	#category : 'PBT-Test generation',
	#package : 'PBT',
	#tag : 'Test generation'
}

{ #category : 'accessing' }
PBTTest >> callInputs: inputs [

	callInputs := inputs
]

{ #category : 'accessing' }
PBTTest >> callResult: aResult [

	callResult := aResult 	
]

{ #category : 'accessing' }
PBTTest >> objectInput: object [

	objectInput := object
]

{ #category : 'accessing' }
PBTTest >> result: testResult [

	result := testResult 
]

{ #category : 'accessing' }
PBTTest >> target: targetMethod [

	target := targetMethod
]
