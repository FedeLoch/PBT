Class {
	#name : 'PBTMutator',
	#superclass : 'Object',
	#instVars : [
		'mutator',
		'weight'
	],
	#category : 'PBT-Mutators',
	#package : 'PBT',
	#tag : 'Mutators'
}

{ #category : 'mutating' }
PBTMutator class >> mutate: aBlock [

	^ self new mutator: aBlock.
]

{ #category : 'initialization' }
PBTMutator >> decreaseWeight [

	weight := ( weight -1 ) max: 1
]

{ #category : 'accessing' }
PBTMutator >> feed: feedback [

	"DO NOTHING"
]

{ #category : 'initialization' }
PBTMutator >> increaseWeight [

	weight := weight + 1
]

{ #category : 'initialization' }
PBTMutator >> initialize [ 
	
	super initialize.
	weight := 1
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

{ #category : 'accessing' }
PBTMutator >> weight [

	^ weight
]
