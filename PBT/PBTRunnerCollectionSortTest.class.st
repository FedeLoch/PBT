Class {
	#name : 'PBTRunnerCollectionSortTest',
	#superclass : 'PBTRunnerTest',
	#category : 'PBT-Runner',
	#package : 'PBT',
	#tag : 'Runner'
}

{ #category : 'tests' }
PBTRunnerCollectionSortTest >> testGivingACollectionIntegerSchemaThenValidateSortResult [

	| objectConstraints assert schema |
	
	objectConstraints := PBTIterableObjectConstraint new
		                     objectClass: OrderedCollection;
		                     item: (PBTObjectConstraint new
				                      objectClass: SmallInteger;
				                      gen: [ 1 to: 100 ]).

	assert := [ :coll :args :result | result = coll sort and: result size = coll size ].

	schema := PBTSchema new objectConstraint: objectConstraints; assert: assert.
	PBTRunner test: OrderedCollection >> #sort from: schema
]
