Class {
	#name : 'PBTMutator',
	#superclass : 'Object',
	#instVars : [
		'mutator'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'mutating' }
PBTMutator class >> mutate: aBlock [

	^ self new mutator: aBlock.
]

{ #category : 'accessing' }
PBTMutator >> mutate: anInput [

	^ mutator value: anInput 
]

{ #category : 'accessing' }
PBTMutator >> mutator [

	^ mutator
]

{ #category : 'accessing' }
PBTMutator >> mutator: aBlock [

	mutator := aBlock 
]
