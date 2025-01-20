Class {
	#name : 'PBTFrameworkTest',
	#superclass : 'TestCase',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'asserting' }
PBTFrameworkTest >> assertSuccess: pbtResult [

	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) size equals: 1.
	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) keys first equals: PBTEvalSuccess.
]

{ #category : 'running' }
PBTFrameworkTest >> setUp [
	super setUp.
	

	"Put here a common initialization logic for tests"
]
