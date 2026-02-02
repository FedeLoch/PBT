Class {
	#name : 'UmeFactorialTest',
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
UmeFactorialTest >> setUp [
	super setUp.
	
	receiverConstraint := UmeObjectConstraint new generator: (UmeGenerator oneOf: (10 to: 100)).
	assert := [ :n :args :result | n * (n - 1) factorial = result ].
	schema := UmeSchema new receiverConstraint: receiverConstraint; assert: assert.
]

{ #category : 'tests' }
UmeFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResult [

	| pbtResult |

	pbtResult := (UmeRunner test: Integer >> #factorial from: schema) run.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 100.
]

{ #category : 'tests' }
UmeFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResultFromSpecificCountOfIterations [

	| pbtResult |

	pbtResult := (UmeRunner test: Integer >> #factorial from: schema times: 2542) run.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 2542.
]

{ #category : 'tests' }
UmeFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResultFromTimeIsnteadOfIterations [

	| pbtResult |

	pbtResult := (UmeRunner test: Integer >> #factorial from: schema for: 2 seconds) run.

	self assertSuccess: pbtResult.
	self assert: (pbtResult totalTime >= 2 seconds) equals: true.
]

{ #category : 'tests' }
UmeFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResultWithoutSchema [
	
	| pbtResult |
	"TODO: Not executable until we support schema inference"
	pbtResult := (UmeRunner test: Integer >> #factorial) run.
	
	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 1000.
]
