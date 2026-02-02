Class {
	#name : 'UmeFactorialWithOptionalGenTest',
	#superclass : 'UmeFrameworkTest',
	#instVars : [
		'schema',
		'receiverConstraint',
		'assert'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeFactorialWithOptionalGenTest >> setUp [
	
	| generators |
	
	generators := {
		UmeGenerator oneOf: (-50000 to: 0).
		UmeGenerator oneOf: (0 to: 50000)
	}.	
	
	super setUp.
	
	receiverConstraint := UmeObjectConstraint new generator:
		(PBTDyncamicSelectionGenerator new generators: generators).
	assert := [ :n :args :result | n * (n - 1) factorial = result ].
	schema := UmeSchema new receiverConstraint: receiverConstraint; assert: assert.
]

{ #category : 'tests' }
UmeFactorialWithOptionalGenTest >> testGivingASmallIntegerSchemaWithDynamicGeneratorsThenValidateFactorialResult [

	| pbtResult |

	pbtResult := (UmeRunner test: Integer >> #factorial from: schema times: 1000) run.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 1000.
]
