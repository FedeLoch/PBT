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

	self assert: (pbtResult tests size) equals: 1000.
	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) size equals: 1.
	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) keys first equals: PBTEvalSuccess.
]

{ #category : 'tests' }
PBTRunnerFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResultFromTimeIsnteadOfIterations [

	| objectConstraints assert pbtResult schema |

	objectConstraints := PBTObjectConstraint new generator: (PBTGen oneOf: (10 to: 100)).
	assert := [ :n :args :result | n * (n - 1) factorial = result ].
	schema := PBTSchema new objectConstraint: objectConstraints; assert: assert.

	pbtResult := PBTRunner test: Integer >> #factorial from: schema for: 2 seconds.

	self assert: (pbtResult totalTime >= 2 seconds) equals: true.
	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) size equals: 1.
	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) keys first equals: PBTEvalSuccess.
]

{ #category : 'tests' }
PBTRunnerFactorialTest >> testGivingASmallIntegerSchemaThenValidateFactorialResultWithoutSchema [
	
	| pbtResult |
	
	pbtResult := PBTRunner test: SmallInteger >> #factorial.
	
	self assert: (pbtResult tests size) equals: 1000.
	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) size equals: 1.
	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) keys first equals: PBTEvalSuccess.
]
