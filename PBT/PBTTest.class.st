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
		'lastResult',
		'autoTunedIterations'
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

{ #category : 'as yet unclassified' }
PBTTest >> autoTuneIterationsFor: duration [
	
	| count startTime deadline |
	
	autoTunedIterations ifNotNil: [ self error: 'che esto ya esta autotuneado' ].
	
	deadline := duration asMilliSeconds.
	startTime := Time now asMilliSeconds.
	count := 0.

	[ self runTime . count := count + 1 ]
		doWhileTrue: [ (Time now asMilliSeconds - startTime) <= deadline ].
	
	^ autoTunedIterations := count.
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
PBTTest >> name [
	
	^ self identityHash 
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

{ #category : 'as yet unclassified' }
PBTTest >> runTime [

	^ (self runTimes: 1) first
]

{ #category : 'as yet unclassified' }
PBTTest >> runTimeAutotuned [

	^ (self runTimes: 1 withInternalIterations: autoTunedIterations) first
]

{ #category : 'as yet unclassified' }
PBTTest >> runTimes: count [

	^ (1 to: count) collect: [ :i | | timeBefore |		
		Smalltalk garbageCollect.
		timeBefore := Smalltalk highResClock.
		receiver perform: target selector withArguments: arguments.
		(Smalltalk highResClock) - timeBefore.
	]
]

{ #category : 'as yet unclassified' }
PBTTest >> runTimes: count withInternalIterations: iterations [

	^ (1 to: count) collect: [ :i | | timeBefore |		
		Smalltalk garbageCollect.
		timeBefore := Smalltalk highResClock.
		1 to: iterations do: [ :_ |
			receiver perform: target selector withArguments: arguments.		
		].
		(Smalltalk highResClock) - timeBefore.
	]
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
