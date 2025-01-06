Class {
	#name : 'PBTRunnerFactorialTest',
	#superclass : 'PBTRunnerTest',
	#category : 'PBT-Runner',
	#package : 'PBT',
	#tag : 'Runner'
}

{ #category : 'tests' }
PBTRunnerFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResult [

	| objectConstraints assert schema |

	objectConstraints := PBTObjectConstraint new gen: [ 1 to: 100 ].
	assert := [ :n :args :result | n * (n - 1) factorial = result ].
	schema := PBTSchema new objectConstraint: objectConstraints; assert: assert.

	PBTRunner test: SmallInteger >> #factorial from: schema
]
