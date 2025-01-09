Class {
	#name : 'PBTObjectGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'tests' }
PBTObjectGeneratorTest >> testGenerateAnInstanceOfACollectionOfIntegers [

	| generator random constraint |
	
	random := Random new nextIntegerBetween: 1 and: 40.
	generator := PBTGenerator onceInstance: [ :instance :props |
		             random timesRepeat: [
			             instance add: (props at: 'item') gen ].
		             instance ].

	constraint := PBTObjectConstraint new
		              objectClass: OrderedCollection;
		              props: { ('item' -> (PBTObjectConstraint new
					                objectClass: SmallInteger;
					                generator: (PBTGenerator always: 42))) }.

	self assert: ((generator gen: constraint) size) equals: random.
	self assert: ((generator gen: constraint) asSet size) equals: 1.
]
