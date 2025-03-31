Class {
	#name : 'PBTTest',
	#superclass : 'TestCase',
	#instVars : [
		'target',
		'arguments',
		'result',
		'score',
		'receiver',
		'feedback',
		'assert',
		'lastResult'
	],
	#category : 'PBT-Test generation',
	#package : 'PBT',
	#tag : 'Test generation'
}

{ #category : 'running' }
PBTTest >> announce: anAnnouncementClass withResult: result [

]

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
PBTTest >> assert [

	^ assert
]

{ #category : 'accessing' }
PBTTest >> assert: anAssert [

	assert := anAssert
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
PBTTest >> lastResult [
	
	^ lastResult
]

{ #category : 'accessing' }
PBTTest >> lastTimeToRun [
	^ result time
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

	| callResult |
	
	callResult := receiver perform: target selector withArguments: arguments.
	lastResult := PBTTestResult new result: (assert value: receiver value: arguments value: callResult).
	^ lastResult 
]

{ #category : 'running' }
PBTTest >> run: aResult [
	aResult runCase: self
]

{ #category : 'running' }
PBTTest >> runCaseManaged [ 
	"TODO: This is a test to integrate"
	self run
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
PBTTest >> selector [
	^ self hash asString asSymbol 
]

{ #category : 'asserting' }
PBTTest >> shouldPass [

	^ true
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
