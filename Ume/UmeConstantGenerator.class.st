Class {
	#name : 'UmeConstantGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'value'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'accessing' }
UmeConstantGenerator >> feed: feedback [

	"do nothing"
]

{ #category : 'accessing' }
UmeConstantGenerator >> gen: myConstraint [

	^ value
]

{ #category : 'accessing' }
UmeConstantGenerator >> value: aValue [

	value := aValue 
]
