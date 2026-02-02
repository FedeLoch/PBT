Class {
	#name : 'UmeMutator',
	#superclass : 'Object',
	#instVars : [
		'mutator',
		'weight'
	],
	#category : 'Ume-Mutators',
	#package : 'Ume',
	#tag : 'Mutators'
}

{ #category : 'mutating' }
UmeMutator class >> mutate: aBlock [

	^ self new mutator: aBlock.
]

{ #category : 'initialization' }
UmeMutator >> decreaseWeight [

	weight := ( weight -1 ) max: 1
]

{ #category : 'accessing' }
UmeMutator >> feed: feedback [

	"DO NOTHING"
]

{ #category : 'initialization' }
UmeMutator >> increaseWeight [

	weight := weight + 1
]

{ #category : 'initialization' }
UmeMutator >> initialize [ 
	
	super initialize.
	weight := 1
]

{ #category : 'accessing' }
UmeMutator >> mutate: anInput [

	^ mutator value: anInput 
]

{ #category : 'accessing' }
UmeMutator >> mutator [

	^ mutator
]

{ #category : 'accessing' }
UmeMutator >> mutator: aBlock [

	mutator := aBlock 
]

{ #category : 'accessing' }
UmeMutator >> weight [

	^ weight
]
