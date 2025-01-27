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
		             instance ] of: OrderedCollection.

	constraint := PBTObjectConstraint new
		              props: { ('item' -> (PBTObjectConstraint new
					                objectClass: SmallInteger;
					                generator: (PBTGenerator always: 42))) }.

	self assert: ((generator gen: constraint) size) equals: random.
	self assert: ((generator gen: constraint) asSet size) equals: 1.
]

{ #category : 'tests' }
PBTObjectGeneratorTest >> testGenerateAnInstanceOfAValidRectangle [

	| generator constraint |
	generator := PBTGenerator onceInstance: [ :instance :props |
		             instance
			             setPoint: (props at: 'origin') gen
			             point: (props at: 'corner') gen.
		             instance ] of: Rectangle.

	constraint := PBTObjectConstraint new
		              props: {
				              ('origin' -> (PBTObjectConstraint new
						                objectClass: Point;
						                generator: PBTPointGenerator new)).
				              ('corner' -> (PBTObjectConstraint new
					                objectClass: Point;
					                generator: PBTPointGenerator new)) }.

	self assert: ((generator gen: constraint) class) equals: Rectangle.
	self assert: ((generator gen: constraint) area >= 0) equals: true.
]
