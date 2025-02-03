Class {
	#name : 'PBTTest',
	#superclass : 'Object',
	#instVars : [
		'target',
		'arguments',
		'result',
		'score',
		'receiver',
		'feedback'
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
PBTTest >> feedback [

	^ feedback
]

{ #category : 'accessing' }
PBTTest >> feedback: aFeedback [

	feedback := aFeedback
]

{ #category : 'accessing' }
PBTTest >> profiledRun [

	^ TimeProfiler spyOn: [ self run ]
]

{ #category : 'accessing' }
PBTTest >> receiver [

	^ receiver
]

{ #category : 'accessing' }
PBTTest >> receiver: anObject [

	receiver := anObject
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
PBTTest >> run [

	^ receiver perform: target selector withArguments: arguments
]

{ #category : 'accessing' }
PBTTest >> score [

	^ score 
]

{ #category : 'accessing' }
PBTTest >> score: aScore [

	score := aScore 
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

	^ result time
]
