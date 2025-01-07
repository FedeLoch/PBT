Class {
	#name : 'PBTSchema',
	#superclass : 'Object',
	#instVars : [
		'objectConstraint',
		'inputConstraints',
		'assert'
	],
	#category : 'PBT-Property Specifcation',
	#package : 'PBT',
	#tag : 'Property Specifcation'
}

{ #category : 'as yet unclassified' }
PBTSchema class >> getProperties: aFile [

	"TODO: Implement me"
]

{ #category : 'accessing' }
PBTSchema >> assert [

	^ assert
]

{ #category : 'accessing' }
PBTSchema >> assert: anAssertBlock [

	assert := anAssertBlock
]

{ #category : 'accessing' }
PBTSchema >> inputConstraints [

	^ inputConstraints 
]

{ #category : 'accessing' }
PBTSchema >> inputConstraints: anInputConstraints [

	inputConstraints := anInputConstraints.
]

{ #category : 'accessing' }
PBTSchema >> objectConstraint [

	^ objectConstraint
]

{ #category : 'accessing' }
PBTSchema >> objectConstraint: aObjectConstraint [

	objectConstraint := aObjectConstraint.
]
