Class {
	#name : 'PBTConstantGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'value'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTConstantGenerator >> feed: feedback [

	"do nothing"
]

{ #category : 'accessing' }
PBTConstantGenerator >> gen: myConstraint [

	^ value
]

{ #category : 'accessing' }
PBTConstantGenerator >> value: aValue [

	value := aValue 
]
