Class {
	#name : 'PBTRunnerPlusTest',
	#superclass : 'PBTRunnerTest',
	#instVars : [
		'objectConstraints',
		'assert',
		'schema',
		'inputConstraints'
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
	objectConstraints := PBTObjectConstraint new generator: (PBTGenerator oneOf: range).
	inputConstraints := {
		PBTObjectConstraint new generator: (PBTGenerator oneOf: range)
	}.
	assert := [ :n :args :result | args first + n = result ].
	schema := PBTSchema new objectConstraint: objectConstraints; inputConstraints: inputConstraints; assert: assert.
]

{ #category : 'tests' }
PBTRunnerPlusTest >> testGivingASmallIntegerSchemaThenValidatePlusResult [

	| pbtResult |

	pbtResult := PBTRunner test: SmallInteger >> #+ from: schema.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 1000.
]
