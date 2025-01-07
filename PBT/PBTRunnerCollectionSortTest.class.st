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
	
	objectConstraints := PBTObjectConstraint new
		                     objectClass: OrderedCollection;
								   generator: (PBTGen onceInstance: [ :instance :props |
										(Random new nextIntegerBetween: 1 and: 100) timesRepeat: [
											instance add: (props at: 'item') gen
									]. instance]);
									props: {
										'item' -> (PBTObjectConstraint new objectClass: SmallInteger; generator: (PBTGen oneOf: (10 to: 100)))
									}.

	assert := [ :coll :args :result | result = coll sort and: result size = coll size ]. "TODO: improve the assertion"
	schema := PBTSchema new objectConstraint: objectConstraints; assert: assert.
	
	pbtResult := PBTRunner test: SequenceableCollection >> #sort from: schema.
	
	self assert: (pbtResult tests size) equals: 1000.
	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) size equals: 1.
	self assert: (pbtResult tests groupedBy: [ :r | r result class ]) keys first equals: PBTEvalSuccess.
	
	
]

{ #category : 'tests' }
PBTRunnerCollectionSortTest >> testGivingACollectionIntegerSchemaThenValidateSortResultWithoutSchema [

	| pbtResult |
	
	pbtResult := PBTRunner test: OrderedCollection >> #sort.
	1 halt.
]
