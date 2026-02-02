Class {
	#name : 'UmeCollectionSortTest',
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
UmeCollectionSortTest >> setUp [

	super setUp.
	self timeLimit: 5 minutes.

	receiverConstraint := UmeObjectConstraint new
		                     generator:
			                     (UmeGenerator onceInstance: [ :instance :props |
					                      (Random new nextIntegerBetween: 1 and: 100)
						                      timesRepeat: [
							                      instance add: (props at: 'item') gen ].
					                      instance ] of: OrderedCollection);
		                     props: { ('item' -> (UmeObjectConstraint new
					                       objectClass: SmallInteger;
					                       generator: (UmeGenerator oneOf: (10 to: 100)))) }.

	assert := [ :coll :args :result |
	          result = coll sort and: result size = coll size ]. "TODO: improve the assertion"
	schema := UmeSchema new
		          receiverConstraint: receiverConstraint ;
		          assert: assert
]

{ #category : 'tests' }
UmeCollectionSortTest >> testGivingACollectionIntegerSchemaThenValidateSortResult [

	| pbtResult |
	
	pbtResult := (UmeRunner test: SequenceableCollection >> #sort from: schema times: 100) run.
	
	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 100.
]

{ #category : 'tests' }
UmeCollectionSortTest >> testGivingACollectionIntegerSchemaThenValidateSortResultWithoutSchema [

	| pbtResult |
	"TODO: Not executable until we support schema inference"
	pbtResult := (UmeRunner test: SequenceableCollection >> #sort) run.
	
	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 100.
]
