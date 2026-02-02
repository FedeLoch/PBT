Class {
	#name : 'UmeGenProbabilityWrapper',
	#superclass : 'UmeGenerator',
	#instVars : [
		'weight',
		'generator'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
UmeGenProbabilityWrapper class >> from: gen [

	^ self new generator: gen
]

{ #category : 'as yet unclassified' }
UmeGenProbabilityWrapper >> decreaseWeight [

	weight := ( weight -1 ) max: 1
]

{ #category : 'accessing' }
UmeGenProbabilityWrapper >> gen: constaint [

	^ generator gen: constaint
]

{ #category : 'accessing' }
UmeGenProbabilityWrapper >> generator: gen [

	generator := gen
]

{ #category : 'as yet unclassified' }
UmeGenProbabilityWrapper >> increaseWeight [

	weight := weight + 1
]

{ #category : 'initialization' }
UmeGenProbabilityWrapper >> initialize [ 
	
	super initialize.
	weight := 1
]

{ #category : 'initialization' }
UmeGenProbabilityWrapper >> weight [

	^ weight 
]
