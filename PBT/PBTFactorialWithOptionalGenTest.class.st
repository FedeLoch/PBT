Class {
	#name : 'PBTFactorialWithOptionalGenTest',
	#superclass : 'PBTFrameworkTest',
	#instVars : [
		'schema',
		'receiverConstraint',
		'assert'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTFactorialWithOptionalGenTest >> setUp [
	
	| generators |
	
	generators := {
		PBTGenerator oneOf: (-50000 to: 0).
		PBTGenerator oneOf: (0 to: 50000)
	}.	
	
	super setUp.
	
	receiverConstraint := PBTObjectConstraint new generator:
		(PBTDyncamicSelectionGenerator new generators: generators).
	assert := [ :n :args :result | n * (n - 1) factorial = result ].
	schema := PBTSchema new receiverConstraint: receiverConstraint; assert: assert.
]

{ #category : 'tests' }
PBTFactorialWithOptionalGenTest >> testGivingASmallIntegerSchemaWithDynamicGeneratorsThenValidateFactorialResult [

	| pbtResult |

	pbtResult := (PBTRunner test: Integer >> #factorial from: schema times: 1000) run.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 1000.
]
