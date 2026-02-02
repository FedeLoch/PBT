Class {
	#name : 'UmeInternalConstraintProperties',
	#superclass : 'Object',
	#instVars : [
		'dict'
	],
	#category : 'Ume-Property Schema',
	#package : 'Ume',
	#tag : 'Property Schema'
}

{ #category : 'instance creation' }
UmeInternalConstraintProperties class >> from: dict [

	^ self new dict: dict
]

{ #category : 'accessing' }
UmeInternalConstraintProperties >> at: key [

	^ dict at: key
]

{ #category : 'accessing' }
UmeInternalConstraintProperties >> at: key put: value [

	dict at: key put: value
]

{ #category : 'accessing' }
UmeInternalConstraintProperties >> dict [

	^ dict
]

{ #category : 'accessing' }
UmeInternalConstraintProperties >> dict: aDict [

	dict := aDict 
]
