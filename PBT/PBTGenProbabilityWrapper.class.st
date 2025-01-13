Class {
	#name : 'PBTGenProbabilityWrapper',
	#superclass : 'PBTGenerator',
	#instVars : [
		'weight',
		'generator'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
PBTGenProbabilityWrapper class >> from: gen [

	^ self new generator: gen
]

{ #category : 'as yet unclassified' }
PBTGenProbabilityWrapper >> decreaseWeight [

	weight := ( weight -1 ) max: 1
]

{ #category : 'accessing' }
PBTGenProbabilityWrapper >> gen: constaint [

	^ generator gen: constaint
]

{ #category : 'accessing' }
PBTGenProbabilityWrapper >> generator: gen [

	generator := gen
]

{ #category : 'as yet unclassified' }
PBTGenProbabilityWrapper >> increaseWeight [

	weight := weight + 1
]

{ #category : 'initialization' }
PBTGenProbabilityWrapper >> initialize [ 
	
	super initialize.
	weight := 1
]

{ #category : 'initialization' }
PBTGenProbabilityWrapper >> weight [

	^ weight 
]
