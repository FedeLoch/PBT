Class {
	#name : 'UmePlusTest',
	#superclass : 'UmeFrameworkTest',
	#instVars : [
		'receiverConstraint',
		'assert',
		'schema',
		'argumentConstraints'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmePlusTest >> setUp [
	
	| range |
	
	super setUp.
	
	range := (SmallInteger minVal to: SmallInteger maxVal).
	receiverConstraint := UmeObjectConstraint new generator: (UmeGenerator oneOf: range).
	argumentConstraints := {
		UmeObjectConstraint new generator: (UmeGenerator oneOf: range)
	}.
	assert := [ :n :args :result | args first + n = result ].
	schema := UmeSchema new receiverConstraint: receiverConstraint; argumentConstraints: argumentConstraints; assert: assert.
]

{ #category : 'as yet unclassified' }
UmePlusTest >> testGivingASmallIntegerSchemaThenValidatePlusResult [

	| pbtResult |

	pbtResult := (UmeRunner test: SmallInteger >> #+ from: schema) run.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 100.
]
