Class {
	#name : 'PBTGenericGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'do',
		'prevFeedback'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
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
PBTGenericGenerator >> feed: feedback [

	prevFeedback := feedback 
]

{ #category : 'accessing' }
PBTGenericGenerator >> gen: constraint [

	^ do value: (constraint ifNotNil: [ constraint props ] ifNil: nil) value: prevFeedback
]
