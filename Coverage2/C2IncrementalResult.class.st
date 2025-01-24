Class {
	#name : 'C2IncrementalResult',
	#superclass : 'Object',
	#instVars : [
		'coveredNodes'
	],
	#category : 'Coverage2',
	#package : 'Coverage2'
}

{ #category : 'as yet unclassified' }
C2IncrementalResult >> collectResult: collector [

	| nodes |
	nodes := (coveredNodes collect: [ :tuple | self resolveNode: tuple ])
		         asSet.

	^ C2CoverageResult new
		  collector: collector;
		  nodes: nodes;
		  methods:
			  (nodes collect: [ :node | node methodNode compiledMethod ]) asSet
]

{ #category : 'as yet unclassified' }
C2IncrementalResult >> coverNode: aNode [

	coveredNodes add: {
			aNode methodNode compiledMethod name.
			aNode path }
]

{ #category : 'as yet unclassified' }
C2IncrementalResult >> initialize [

	super initialize.
	coveredNodes := Set new
]

{ #category : 'as yet unclassified' }
C2IncrementalResult >> resolveNode: tuple [

	^(Object readFrom: tuple first) ast childAtPath: tuple second 
	

]
