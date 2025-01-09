Class {
	#name : 'PBTGenerator',
	#superclass : 'Object',
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTGenerator class >> always: aValue [

	^ PBTConstantGenerator new value: aValue.
]

{ #category : 'as yet unclassified' }
PBTGenerator class >> onceInstance: aBlock [

	^ PBTObjectGenerator new then: aBlock 
]

{ #category : 'as yet unclassified' }
PBTGenerator class >> oneOf: aRange [

	^ PBTOptionsGenerator new from: aRange.
]

{ #category : 'as yet unclassified' }
PBTGenerator >> gen: instance [
	
	self subclassResponsibility 
]
