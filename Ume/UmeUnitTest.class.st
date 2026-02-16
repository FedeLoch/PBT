Class {
	#name : 'UmeUnitTest',
	#superclass : 'TestCase',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Unit Testing Integration',
	#package : 'Ume',
	#tag : 'Unit Testing Integration'
}

{ #category : 'running' }
UmeUnitTest >> argumentGenerators [

	self subclassResponsibility 
]

{ #category : 'running' }
UmeUnitTest >> assert: receiver arguments: arguments result: result [

	"TODO: REWRITE ME IF YOU WANT TO CUSTOM ME"
	^ true
]

{ #category : 'running' }
UmeUnitTest >> constantGen: obj [

	^ UmeConstantGenerator new value: obj
]

{ #category : 'running' }
UmeUnitTest >> corpusGenFrom: seed mpi: mpi mutators: mutators [

	^ UmeCorpusGenerator new
		  seeds: { seed };
		  mutationsPerIteration: mpi;
		  mutators: mutators;
		  heuristic: UmePickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
UmeUnitTest >> doRegressionTest: case [

	| receiver arguments targetSelector expectedFeedback profilingResult feedbackEvaluator evaluator program umeCase |

	receiver := STON fromString: (case at: 'receiver').
	arguments := STON fromString: (case at: 'arguments').
	targetSelector := case at: 'method'.
	expectedFeedback := STON fromString: (case at: 'expected').
	feedbackEvaluator := STON fromString: (case at: 'feedbackSystem').
	evaluator := STON fromString: (case at: 'evaluator').

	program := PBAProgram from:
			[ receiver perform: targetSelector withArguments: arguments ]
		forClasses: (evaluator classesFor: targetSelector).

	profilingResult := evaluator analyzer analyze: program.
	
	umeCase := UmeTest new result: (UmeEvalSuccess new profilingResult: profilingResult).

	self assert: (feedbackEvaluator eval: umeCase) relevantValues equals: expectedFeedback
]

{ #category : 'running' }
UmeUnitTest >> doTest: case [

	| receiver arguments targetSelector result |
	receiver := STON fromString: (case at: 'receiver').
	arguments := STON fromString: (case at: 'arguments').

	targetSelector := case at: 'method'.

	result := receiver perform: targetSelector withArguments: arguments.
	self assert: (self assert: receiver arguments: arguments result: result)
]

{ #category : 'running' }
UmeUnitTest >> generateRegressionTests: duration [

	self generateRegressionUnitTests: (self runUme: duration)
]

{ #category : 'running' }
UmeUnitTest >> generateRegressionUnitTests: result [

	result topCases do: [ :t | t installRegressionUnitTestIn: self ]
]

{ #category : 'running' }
UmeUnitTest >> generateTests [

	<script: 'self new generateTests'>
	
	self generateUnitTests: (self runUme: self generationTime)
]

{ #category : 'running' }
UmeUnitTest >> generateTests: duration [

	self generateUnitTests: (self runUme: duration)
]

{ #category : 'running' }
UmeUnitTest >> generateUnitTests: result [

	result topCases do: [ :t | t installUnitTestIn: self ]
]

{ #category : 'running' }
UmeUnitTest >> generationTime [

	"TODO: REWRITE ME IF YOU WANT TO CUSTOM ME"
	^ 5 minutes

]

{ #category : 'running' }
UmeUnitTest >> guidedBy [

	"TODO: REWRITE ME IF YOU WANT TO CUSTOM ME"
	self guidedByMethodsCalls
]

{ #category : 'running' }
UmeUnitTest >> guidedByAllocatedMemory [

	runner guidedByAllocatedMemory
]

{ #category : 'running' }
UmeUnitTest >> guidedByBytecodes [

	runner guidedByBytecodes
]

{ #category : 'running' }
UmeUnitTest >> guidedByCoverage [

	runner guidedByCoverage
]

{ #category : 'running' }
UmeUnitTest >> guidedByExecutionTime [

	runner guidedByExecutionTime
]

{ #category : 'running' }
UmeUnitTest >> guidedByMethodsCalls [

	runner guidedByMethodsCalls
]

{ #category : 'running' }
UmeUnitTest >> guidedByScore [

	runner guidedByScore
]

{ #category : 'running' }
UmeUnitTest >> instanceRunner: duration [

	runner := UmeRunner test: self targetMethod from: self schema for: duration
]

{ #category : 'running' }
UmeUnitTest >> receiverGenerator [

	self subclassResponsibility 
]

{ #category : 'running' }
UmeUnitTest >> regressionTestName: umeTest [

	"TODO: REWRITE ME IF YOU WANT TO CUSTOM ME"
	^ 'test_regression_', umeTest name asString
]

{ #category : 'running' }
UmeUnitTest >> runUme: duration [

	self instanceRunner: duration.
	self guidedBy.

	^ runner run
]

{ #category : 'running' }
UmeUnitTest >> runner [

	^ runner
]

{ #category : 'running' }
UmeUnitTest >> schema [

	| receiverConstraint argumentConstraints |
	receiverConstraint := UmeObjectConstraint new generator: self receiverGenerator.

	argumentConstraints := self argumentGenerators collect: [ :generator |
		UmeObjectConstraint new generator: generator
	].

	^ UmeSchema new
		receiverConstraint: receiverConstraint;
		argumentConstraints: argumentConstraints;
		score: [ :rcv :args :res | self score: rcv arguments: args result: res ];
		assert: [ :rcv :args :res | self assert: rcv arguments: args result: res ].
]

{ #category : 'running' }
UmeUnitTest >> score: receiver arguments: arguments result: result [

	"TODO: REWRITE ME IF YOU WANT TO CUSTOM ME"
	^ 1
]

{ #category : 'running' }
UmeUnitTest >> setUp [ 
	
	super setUp.
	self timeLimit: 5 hours.
]

{ #category : 'running' }
UmeUnitTest >> targetMethod [

	self subclassResponsibility 
]

{ #category : 'running' }
UmeUnitTest >> testName: umeTest [

	"TODO: REWRITE ME IF YOU WANT TO CUSTOM ME"
	^ 'test_', umeTest name asString
]
