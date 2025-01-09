Class {
	#name : 'PBTGenerator',
	#superclass : 'Object',
	#category : 'PBT-Input Generation',
	#package : 'PBT',
	#tag : 'Input Generation'
}

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
