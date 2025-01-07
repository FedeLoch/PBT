Class {
	#name : 'PBTRunnerTest',
	#superclass : 'TestCase',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'asserting' }
PBTRunnerTest >> assertSuccess: pbtResult [

	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) size equals: 1.
	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) keys first equals: PBTEvalSuccess.
]

{ #category : 'running' }
PBTRunnerTest >> setUp [
	super setUp.
	

	"Put here a common initialization logic for tests"
]
