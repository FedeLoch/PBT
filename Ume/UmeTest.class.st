Class {
	#name : 'UmeTest',
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
	#category : 'Ume-Test generation',
	#package : 'Ume',
	#tag : 'Test generation'
}

{ #category : 'ston-core' }
UmeTest class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( target assert )
]

{ #category : 'running' }
UmeTest >> announce: anAnnouncementClass withResult: result [

]

{ #category : 'accessing' }
UmeTest >> arguments [

	^ arguments
]

{ #category : 'accessing' }
UmeTest >> arguments: inputs [

	arguments := inputs
]

{ #category : 'as yet unclassified' }
UmeTest >> argumentsString [

	^ (STON toString: arguments) fullPrintString
]

{ #category : 'accessing' }
UmeTest >> assert [

	^ assert
]

{ #category : 'accessing' }
UmeTest >> assert: anAssert [

	assert := anAssert
]

{ #category : 'as yet unclassified' }
UmeTest >> autoTuneIterationsFor: duration [
	
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
UmeTest >> autoTunedIterations [
	^ autoTunedIterations
]

{ #category : 'accessing' }
UmeTest >> feedback [

	^ feedback
]

{ #category : 'accessing' }
UmeTest >> feedback: aFeedback [

	feedback := aFeedback
]

{ #category : 'as yet unclassified' }
UmeTest >> installRegressionUnitTestIn: aUmeUnitTest [
	
	| selector sourceCode feedbackSystem evaluator expected |
	
	selector := (aUmeUnitTest regressionTestName: self) asSymbol.

	feedbackSystem := STON toString: aUmeUnitTest runner feedbackEvaluator clear.
	evaluator := STON toString: aUmeUnitTest runner evaluator.
	expected := STON toString: feedback relevantValues.

	sourceCode := String streamContents: [ :s | s  nextPutAll: selector; crtab;
     	nextPutAll: '
		self doRegressionTest: {
			', $' asString, 'method', $' asString, ' -> (', target name, ') selector.
			', $' asString, 'receiver', $' asString, ' -> ', self receiverString, '.
			', $' asString, 'arguments', $' asString, ' -> ', self argumentsString, '.
			', $' asString, 'expected', $' asString, ' -> ', expected printString, '.
			', $' asString, 'evaluator', $' asString, ' -> ', evaluator printString, '.
			', $' asString, 'feedbackSystem', $' asString, ' -> ', feedbackSystem printString, '.
		} asDictionary
	'].

    aUmeUnitTest class
        compile: sourceCode
        classified: 'Ume dynamic regression tests'.
	
    ^ selector
]

{ #category : 'as yet unclassified' }
UmeTest >> installUnitTestIn: aUmeUnitTest [
	
	| selector sourceCode |
	selector := (aUmeUnitTest testName: self) asSymbol.

	sourceCode := String streamContents: [ :s | s  nextPutAll: selector; crtab;
     	nextPutAll: '
		self doTest: {
			', $' asString, 'method', $' asString, ' -> (', target name, ') selector.
			', $' asString, 'receiver', $' asString, ' -> ', self receiverString, '.
			', $' asString, 'arguments', $' asString, ' -> ', self argumentsString, '.
		} asDictionary
	'].

    aUmeUnitTest class
        compile: sourceCode
        classified: 'Ume dynamic tests'.

    ^ selector
]

{ #category : 'accessing' }
UmeTest >> lastResult [
	
	^ lastResult
]

{ #category : 'accessing' }
UmeTest >> lastTimeToRun [
	^ result time
]

{ #category : 'accessing' }
UmeTest >> name [
	
	id ifNil: [ id := self identityHash ].
	
	^ id
]

{ #category : 'accessing' }
UmeTest >> profiledRun [

	^ TimeProfiler spyOn: [ self run ]
]

{ #category : 'accessing' }
UmeTest >> receiver [

	^ receiver
]

{ #category : 'accessing' }
UmeTest >> receiver: anObject [

	receiver := anObject
]

{ #category : 'as yet unclassified' }
UmeTest >> receiverString [

	^ (STON toString: receiver) fullPrintString
]

{ #category : 'as yet unclassified' }
UmeTest >> resetAutotune [

	autoTunedIterations := nil.
]

{ #category : 'accessing' }
UmeTest >> result [

	^ result
]

{ #category : 'accessing' }
UmeTest >> result: testResult [

	result := testResult 
]

{ #category : 'accessing' }
UmeTest >> run [

	| callResult testResult |
	
	callResult := receiver perform: targetSelector withArguments: arguments.
	testResult := assert ifNil:
		[ true ] ifNotNil: [ assert value: receiver value: arguments value: callResult ].
	lastResult := UmeTestResult new result: testResult.
	^ lastResult 
]

{ #category : 'running' }
UmeTest >> run: aResult [
	aResult runCase: self
]

{ #category : 'running' }
UmeTest >> runCaseManaged [ 
	"TODO: This is a test to integrate"
	self run
]

{ #category : 'as yet unclassified' }
UmeTest >> runTime [

	^ (self runTimes: 1) first
]

{ #category : 'as yet unclassified' }
UmeTest >> runTimeAutotuned [

	^ (self runTimes: 3 withInternalIterations: autoTunedIterations) last
]

{ #category : 'as yet unclassified' }
UmeTest >> runTimes: count [

	^ (1 to: count) collect: [ :i | | timeBefore |		
		Smalltalk garbageCollect.
		timeBefore := Smalltalk highResClock.
		receiver perform: targetSelector withArguments: arguments.
		(Smalltalk highResClock) - timeBefore.
	]
]

{ #category : 'as yet unclassified' }
UmeTest >> runTimes: count withInternalIterations: iterations [

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
UmeTest >> score [

	^ score 
]

{ #category : 'accessing' }
UmeTest >> score: aScore [

	score := aScore 
]

{ #category : 'accessing' }
UmeTest >> selector [
	^ self hash asString asSymbol 
]

{ #category : 'asserting' }
UmeTest >> shouldPass [

	^ true
]

{ #category : 'accessing' }
UmeTest >> target [

	^ target
]

{ #category : 'accessing' }
UmeTest >> target: targetMethod [

	target := targetMethod.
	targetSelector := target selector
]

{ #category : 'accessing' }
UmeTest >> targetSelector: selector [

	targetSelector := selector
]

{ #category : 'accessing' }
UmeTest >> time [

	^ result time
]
