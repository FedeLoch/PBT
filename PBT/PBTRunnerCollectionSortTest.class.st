Class {
	#name : 'PBTRunnerCollectionSortTest',
	#superclass : 'PBTRunnerTest',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'tests' }
PBTRunnerCollectionSortTest >> testGivingACollectionIntegerSchemaThenValidateSortResult [

	| objectConstraints assert pbtResult schema |
	
	objectConstraints := PBTIterableObjectConstraint new
		                     objectClass: OrderedCollection;
		                     item: (PBTObjectConstraint new
				                      objectClass: SmallInteger;
				                      generator: (PBTGen oneOf: (10 to: 100))).

	assert := [ :coll :args :result | result = coll sort and: result size = coll size ].

	schema := PBTSchema new objectConstraint: objectConstraints; assert: assert.
	pbtResult := PBTRunner test: OrderedCollection >> #sort from: schema.
	1 halt.
]

{ #category : 'tests' }
PBTRunnerCollectionSortTest >> testGivingACollectionIntegerSchemaThenValidateSortResultWithoutSchema [

	| pbtResult |
	
	pbtResult := PBTRunner test: OrderedCollection >> #sort.
	1 halt.
]
