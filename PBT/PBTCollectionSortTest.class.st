Class {
	#name : 'PBTCollectionSortTest',
	#superclass : 'PBTFrameworkTest',
	#instVars : [
		'schema',
		'receiverConstraint',
		'assert'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTCollectionSortTest >> setUp [

	super setUp.
	self timeLimit: 5 minutes.

	receiverConstraint := PBTObjectConstraint new
		                     generator:
			                     (PBTGenerator onceInstance: [ :instance :props |
					                      (Random new nextIntegerBetween: 1 and: 100)
						                      timesRepeat: [
							                      instance add: (props at: 'item') gen ].
					                      instance ] of: OrderedCollection);
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
	
	pbtResult := (PBTRunner test: SequenceableCollection >> #sort from: schema times: 100) run.
	
	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 100.
]

{ #category : 'tests' }
PBTCollectionSortTest >> testGivingACollectionIntegerSchemaThenValidateSortResultWithoutSchema [

	| pbtResult |
	"TODO: Not executable until we support schema inference"
	pbtResult := (PBTRunner test: SequenceableCollection >> #sort) run.
	
	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 100.
]
