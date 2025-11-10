Class {
	#name : 'PBTUnitTest',
	#superclass : 'TestCase',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Unit Testing Integration',
	#package : 'PBT',
	#tag : 'Unit Testing Integration'
}

{ #category : 'running' }
PBTUnitTest >> argumentGenerators [

	self subclassResponsibility 
]

{ #category : 'running' }
PBTUnitTest >> assert: receiver arguments: arguments result: result [

	"TODO: REWRITE ME IF YOU WANT TO CUSTOM ME"
	^ true
]

{ #category : 'running' }
PBTUnitTest >> constantGen: obj [

	^ PBTConstantGenerator new value: obj
]

{ #category : 'running' }
PBTUnitTest >> corpusGenFrom: seed mpi: mpi mutators: mutators [

	^ PBTCorpusWithMutationsGenerator new
		  seedGenerator: (PBTConstantGenerator new value: seed);
		  mutationsPerIteration: mpi;
		  mutators: mutators;
		  heuristic: PBTPickBestElementDifferenceHeuristic new
]

{ #category : 'running' }
PBTUnitTest >> generateTests [

	<script: 'self new generateTests'>
	
	self generateUnitTests: self runPBT.
	
	"only rewrite this ?"
]

{ #category : 'running' }
PBTUnitTest >> generateUnitTests: pbtResult [

	pbtResult topCases do: [ :t | t installIn: self ]
]

{ #category : 'running' }
PBTUnitTest >> generationTime [

	"TODO: REWRITE ME IF YOU WANT TO CUSTOM ME"
	^ 5 minutes

]

{ #category : 'running' }
PBTUnitTest >> guidedBy [

	"TODO: REWRITE ME IF YOU WANT TO CUSTOM ME"
	self guidedByMethodsCalls
]

{ #category : 'running' }
PBTUnitTest >> guidedByAllocatedMemory [

	runner guidedByAllocatedMemory
]

{ #category : 'running' }
PBTUnitTest >> guidedByBytecodes [

	1 halt.
]

{ #category : 'running' }
PBTUnitTest >> guidedByCoverage [

	runner guidedByCoverage
]

{ #category : 'running' }
PBTUnitTest >> guidedByExecutionTime [

	runner guidedByExecutionTime
]

{ #category : 'running' }
PBTUnitTest >> guidedByMethodsCalls [

	runner guidedByMethodsCalls
]

{ #category : 'running' }
PBTUnitTest >> guidedByScore [

	runner guidedByScore
]

{ #category : 'running' }
PBTUnitTest >> instanceRunner [

	runner := PBTRunner test: self targetMethod from: self schema for: self generationTime.
]

{ #category : 'running' }
PBTUnitTest >> receiverGenerator [

	self subclassResponsibility 
]

{ #category : 'running' }
PBTUnitTest >> runPBT [

	self instanceRunner.
	self guidedBy.

	^ runner run
]

{ #category : 'running' }
PBTUnitTest >> schema [

	| receiverConstraint argumentConstraints |
	receiverConstraint := PBTObjectConstraint new generator: self receiverGenerator.

	argumentConstraints := self argumentGenerators collect: [ :generator |
		PBTObjectConstraint new generator: generator
	].

	^ PBTSchema new
		receiverConstraint: receiverConstraint;
		argumentConstraints: argumentConstraints;
		score: [ :rcv :args :res | self score: rcv arguments: args result: res ];
		assert: [ :rcv :args :res | self assert: rcv arguments: args result: res ].
]

{ #category : 'running' }
PBTUnitTest >> score: receiver arguments: arguments result: result [

	"TODO: REWRITE ME IF YOU WANT TO CUSTOM ME"
	^ 1
]

{ #category : 'running' }
PBTUnitTest >> setUp [ 
	
	super setUp.
	self timeLimit: 5 hours.
]

{ #category : 'running' }
PBTUnitTest >> targetMethod [

	self subclassResponsibility 
]

{ #category : 'running' }
PBTUnitTest >> testName: pbtTest [

	"TODO: REWRITE ME IF YOU WANT TO CUSTOM ME"
	^ 'test_', pbtTest name asString
]
