Class {
	#name : 'PBTGen',
	#superclass : 'Object',
	#category : 'PBT-Input Generation',
	#package : 'PBT',
	#tag : 'Input Generation'
}

{ #category : 'as yet unclassified' }
PBTGen class >> onceInstance: aBlock [

	^ PBTObjectGen new then: aBlock 
]

{ #category : 'as yet unclassified' }
PBTGen class >> oneOf: aRange [

	^ PBTRangeGen new from: aRange.
]

{ #category : 'as yet unclassified' }
PBTGen >> gen: instance [
	
	self subclassResponsibility 
]
