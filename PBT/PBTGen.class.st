Class {
	#name : 'PBTGen',
	#superclass : 'Object',
	#category : 'PBT-Input Generation',
	#package : 'PBT',
	#tag : 'Input Generation'
}

{ #category : 'as yet unclassified' }
PBTGen class >> oneOf: aRange [

	^ PBTRangeGen new from: aRange.
]

{ #category : 'as yet unclassified' }
PBTGen >> gen [
	
	self subclassResponsibility 
]
