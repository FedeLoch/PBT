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
		'autoTunedIterations',
		'id',
		'targetSelector'
	],
	#category : 'PBT-Test generation',
	#package : 'PBT',
	#tag : 'Test generation'
}

{ #category : 'ston-core' }
PBTTest class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( target assert )
]

{ #category : 'running' }
PBTTest >> announce: anAnnouncementClass withResult: result [

]

{ #category : 'accessing' }
PBTTest >> arguments [

	^ arguments
]

{ #category : 'accessing' }
PBTTest >> arguments: inputs [

	arguments := inputs
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
PBTTest >> autoTunedIterations [
	^ autoTunedIterations
]

{ #category : 'accessing' }
PBTTest >> feedback [

	^ feedback
]

{ #category : 'accessing' }
PBTTest >> feedback: aFeedback [

	feedback := aFeedback
]

{ #category : 'as yet unclassified' }
PBTTest >> installIn: aPBTUnitTest [
	
	| selector sourceCode receiverString argumentsString |
	selector := (aPBTUnitTest testName: self) asSymbol.
	
	receiverString := $' asString, (STON toString: receiver), $' asString.
	argumentsString := STON toString: arguments.
		
	sourceCode := String streamContents: [ :s | s  nextPutAll: selector; crtab;
     	nextPutAll: '
		| receiver arguments result targetSelector |
		
		receiver := STON fromString: ',  receiverString, '.
		arguments := STON fromString: ', argumentsString, ' asString.
		
		targetSelector := (', target name, ') selector.
		
		result := receiver perform: targetSelector withArguments: arguments.
		self assert: receiver arguments: arguments result: result
	'].
    aPBTUnitTest class
        compile: sourceCode
        classified: 'PBT dynamic tests'.

    ^ selector
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
	
	id ifNil: [ id := self identityHash ].
	
	^ id
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

{ #category : 'as yet unclassified' }
PBTTest >> resetAutotune [

	autoTunedIterations := nil.
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

	| callResult testResult |
	
	callResult := receiver perform: targetSelector withArguments: arguments.
	testResult := assert ifNil:
		[ true ] ifNotNil: [ assert value: receiver value: arguments value: callResult ].
	lastResult := PBTTestResult new result: testResult.
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

	^ (self runTimes: 3 withInternalIterations: autoTunedIterations) last
]

{ #category : 'as yet unclassified' }
PBTTest >> runTimes: count [

	^ (1 to: count) collect: [ :i | | timeBefore |		
		Smalltalk garbageCollect.
		timeBefore := Smalltalk highResClock.
		receiver perform: targetSelector withArguments: arguments.
		(Smalltalk highResClock) - timeBefore.
	]
]

{ #category : 'as yet unclassified' }
PBTTest >> runTimes: count withInternalIterations: iterations [

	^ (1 to: count) collect: [ :i | | timeBefore |		
		Smalltalk garbageCollect.
		timeBefore := Smalltalk highResClock.
		1 to: iterations do: [ :_ |
			receiver perform: targetSelector withArguments: arguments.		
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

	target := targetMethod.
	targetSelector := target selector
]

{ #category : 'accessing' }
PBTTest >> targetSelector: selector [

	targetSelector := selector
]

{ #category : 'accessing' }
PBTTest >> time [

	^ result time
]
