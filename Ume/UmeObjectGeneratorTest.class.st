Class {
	#name : 'UmeObjectGeneratorTest',
	#superclass : 'UmeGeneratorTest',
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'tests' }
UmeObjectGeneratorTest >> testGenerateAnInstanceOfACollectionOfIntegers [

	| generator random constraint |
	
	random := Random new nextIntegerBetween: 1 and: 40.
	generator := UmeGenerator onceInstance: [ :instance :props |
		             random timesRepeat: [
			             instance add: (props at: 'item') gen ].
		             instance ] of: OrderedCollection.

	constraint := UmeObjectConstraint new
		              props: { ('item' -> (UmeObjectConstraint new
					                objectClass: SmallInteger;
					                generator: (UmeGenerator always: 42))) }.

	self assert: ((generator gen: constraint) size) equals: random.
	self assert: ((generator gen: constraint) asSet size) equals: 1.
]

{ #category : 'tests' }
UmeObjectGeneratorTest >> testGenerateAnInstanceOfAValidRectangle [

	| generator constraint |
	generator := UmeGenerator onceInstance: [ :instance :props |
		             instance
			             setPoint: (props at: 'origin') gen
			             point: (props at: 'corner') gen.
		             instance ] of: Rectangle.

	constraint := UmeObjectConstraint new
		              props: {
				              ('origin' -> (UmeObjectConstraint new
						                objectClass: Point;
						                generator: UmePointGenerator new)).
				              ('corner' -> (UmeObjectConstraint new
					                objectClass: Point;
					                generator: UmePointGenerator new)) }.

	self assert: ((generator gen: constraint) class) equals: Rectangle.
	self assert: ((generator gen: constraint) area >= 0) equals: true.
]
