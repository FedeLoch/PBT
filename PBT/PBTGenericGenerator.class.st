Class {
	#name : 'PBTGenericGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'do'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'ston-core' }
PBTGenericGenerator class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( do )
]

{ #category : 'accessing' }
PBTGenericGenerator >> do [

	^ do
]

{ #category : 'accessing' }
PBTGenericGenerator >> do: aBlock [

	do := aBlock
]

{ #category : 'accessing' }
PBTGenericGenerator >> gen: constraint by: aFeedback [

	^ do value: (constraint ifNotNil: [ constraint props ] ifNil: nil) value: aFeedback
]
