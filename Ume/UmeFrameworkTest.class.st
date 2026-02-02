Class {
	#name : 'UmeFrameworkTest',
	#superclass : 'TestCase',
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'asserting' }
UmeFrameworkTest >> assertSuccess: pbtResult [

	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) size equals: 1.
	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) keys first equals: UmeEvalSuccess.
]

{ #category : 'running' }
UmeFrameworkTest >> setUp [
	super setUp.
	

	"Put here a common initialization logic for tests"
]
