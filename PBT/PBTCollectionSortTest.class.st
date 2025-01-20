Class {
	#name : 'PBTCollectionSortTest',
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
PBTCollectionSortTest >> setUp [

	super setUp.

	receiverConstraint := PBTObjectConstraint new
		                     objectClass: OrderedCollection;
		                     generator:
			                     (PBTGenerator onceInstance: [ :instance :props |
					                      (Random new nextIntegerBetween: 1 and: 100)
						                      timesRepeat: [
							                      instance add: (props at: 'item') gen ].
					                      instance ]);
		                     props: { ('item' -> (PBTObjectConstraint new
					                       objectClass: SmallInteger;
					                       generator: (PBTGenerator oneOf: (10 to: 100)))) }.

	assert := [ :coll :args :result |
	          result = coll sort and: result size = coll size ]. "TODO: improve the assertion"
	schema := PBTSchema new
		          receiverConstraint: receiverConstraint ;
		          assert: assert
]

{ #category : 'tests' }
PBTCollectionSortTest >> testGivingACollectionIntegerSchemaThenValidateSortResult [

	| pbtResult |
	
	pbtResult := PBTRunner test: SequenceableCollection >> #sort from: schema.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 100.
]

{ #category : 'tests' }
PBTCollectionSortTest >> testGivingACollectionIntegerSchemaThenValidateSortResultWithoutSchema [

	| pbtResult |
	"TODO: Not executable until we support schema inference"
	pbtResult := PBTRunner test: SequenceableCollection >> #sort.
	
	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 100.
]