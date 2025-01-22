Class {
	#name : 'InternalConstraintProperties',
	#superclass : 'Object',
	#instVars : [
		'dict'
	],
	#category : 'PBT-Property Schema',
	#package : 'PBT',
	#tag : 'Property Schema'
}

{ #category : 'instance creation' }
InternalConstraintProperties class >> from: dict [

	^ self new dict: dict
]

{ #category : 'accessing' }
InternalConstraintProperties >> at: key [

	^ dict at: key
]

{ #category : 'accessing' }
InternalConstraintProperties >> at: key put: value [

	dict at: key put: value
]

{ #category : 'accessing' }
InternalConstraintProperties >> dict [

	^ dict
]

{ #category : 'accessing' }
InternalConstraintProperties >> dict: aDict [

	dict := aDict 
]
