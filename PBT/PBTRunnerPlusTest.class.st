Class {
	#name : 'PBTRunnerPlusTest',
	#superclass : 'PBTRunnerTest',
	#instVars : [
		'receiverConstraint',
		'assert',
		'schema',
		'argumentConstraints'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRunnerPlusTest >> setUp [
	
	| range |
	
	super setUp.
	
	range := (SmallInteger minVal to: SmallInteger maxVal).
	receiverConstraint := PBTObjectConstraint new generator: (PBTGenerator oneOf: range).
	argumentConstraints := {
		PBTObjectConstraint new generator: (PBTGenerator oneOf: range)
	}.
	assert := [ :n :args :result | args first + n = result ].
	schema := PBTSchema new receiverConstraint: receiverConstraint; argumentConstraints: argumentConstraints; assert: assert.
]

{ #category : 'as yet unclassified' }
PBTRunnerPlusTest >> testGivingASmallIntegerSchemaThenValidatePlusResult [

	| pbtResult |

	pbtResult := PBTRunner test: SmallInteger >> #+ from: schema.
	
	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 100.
]
