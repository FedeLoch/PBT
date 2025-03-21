Class {
	#name : 'PBTFactorialTest',
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
PBTFactorialTest >> setUp [
	super setUp.
	
	receiverConstraint := PBTObjectConstraint new generator: (PBTGenerator oneOf: (10 to: 100)).
	assert := [ :n :args :result | n * (n - 1) factorial = result ].
	schema := PBTSchema new receiverConstraint: receiverConstraint; assert: assert.
]

{ #category : 'tests' }
PBTFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResult [

	| pbtResult |

	pbtResult := PBTRunner test: Integer >> #factorial from: schema.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 100.
]

{ #category : 'tests' }
PBTFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResultFromSpecificCountOfIterations [

	| pbtResult |

	pbtResult := PBTRunner test: Integer >> #factorial from: schema times: 2542.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 2542.
]

{ #category : 'tests' }
PBTFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResultFromTimeIsnteadOfIterations [

	| pbtResult |

	pbtResult := PBTRunner test: Integer >> #factorial from: schema for: 2 seconds.

	self assertSuccess: pbtResult.
	self assert: (pbtResult totalTime >= 2 seconds) equals: true.
]

{ #category : 'tests' }
PBTFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResultWithoutSchema [
	
	| pbtResult |
	"TODO: Not executable until we support schema inference"
	pbtResult := PBTRunner test: Integer >> #factorial.
	
	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 1000.
]
