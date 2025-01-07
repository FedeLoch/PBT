Class {
	#name : 'PBTTest',
	#superclass : 'Object',
	#instVars : [
		'target',
		'arguments',
		'object',
		'result'
	],
	#category : 'PBT-Test generation',
	#package : 'PBT',
	#tag : 'Test generation'
}

{ #category : 'accessing' }
PBTTest >> arguments: inputs [

	arguments := inputs
]

{ #category : 'accessing' }
PBTTest >> object: anObject [

	object := anObject
]

{ #category : 'accessing' }
PBTTest >> result: testResult [

	result := testResult 
]

{ #category : 'accessing' }
PBTTest >> target: targetMethod [

	target := targetMethod
]
