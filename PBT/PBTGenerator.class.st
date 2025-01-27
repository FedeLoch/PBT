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
PBTGenerator class >> base: baseBlock mutating: mutationBlock [

	^ PBTHillClimbingGenerator new genBase: baseBlock; mutate: mutationBlock 
]

{ #category : 'as yet unclassified' }
PBTGenerator class >> do: aBlock [

	^ PBTGenericGenerator new do: aBlock.
]

{ #category : 'as yet unclassified' }
PBTGenerator class >> onceInstance: aBlock [

	^ PBTObjectGenerator new then: aBlock 
]

{ #category : 'as yet unclassified' }
PBTGenerator class >> onceInstance: aBlock of: aClass [

	^ PBTObjectGenerator new then: aBlock; objectClass: aClass
]

{ #category : 'as yet unclassified' }
PBTGenerator class >> oneOf: options [

	^ PBTOptionsGenerator new from: options.
]

{ #category : 'as yet unclassified' }
PBTGenerator >> gen: instance [
	
	self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
PBTGenerator >> gen: constraint by: aFeedback [
	^ self gen: constraint 
]
