Class {
	#name : 'PBTTest',
	#superclass : 'Object',
	#instVars : [
		'target',
		'arguments',
		'object',
		'result',
		'time'
	],
	#category : 'PBT-Test generation',
	#package : 'PBT',
	#tag : 'Test generation'
}

{ #category : 'accessing' }
PBTTest >> arguments: inputs [

	arguments := inputs
]

{ #category : 'converting' }
PBTTest >> asPharoTest [
	
	"Returns the pharo code that reprensents the test which the same semantics"

	"TODO: Implement me"
]

{ #category : 'accessing' }
PBTTest >> object [

	^ object
]

{ #category : 'accessing' }
PBTTest >> object: anObject [

	object := anObject
]

{ #category : 'accessing' }
PBTTest >> result [

	^ result
]

{ #category : 'accessing' }
PBTTest >> result: testResult [

	result := testResult 
]

{ #category : 'accessing' }
PBTTest >> target [

	^ target
]

{ #category : 'accessing' }
PBTTest >> target: targetMethod [

	target := targetMethod
]

{ #category : 'accessing' }
PBTTest >> time [

	^ time
]

{ #category : 'accessing' }
PBTTest >> time: aTime [

	time := aTime
]
