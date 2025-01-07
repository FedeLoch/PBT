Class {
	#name : 'PBTRunnerFactorialTest',
	#superclass : 'PBTRunnerTest',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'tests' }
PBTRunnerFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResult [

	| objectConstraints assert pbtResult schema |

	objectConstraints := PBTObjectConstraint new generator: (PBTGen oneOf: (10 to: 100)).
	assert := [ :n :args :result | n * (n - 1) factorial = result ].
	schema := PBTSchema new objectConstraint: objectConstraints; assert: assert.

	pbtResult := PBTRunner test: Integer >> #factorial from: schema.
	1 halt.
]

{ #category : 'tests' }
PBTRunnerFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResultWithoutSchema [
	
	| pbtResult |
	
	pbtResult := PBTRunner test: SmallInteger >> #factorial.
	1 halt.
]
