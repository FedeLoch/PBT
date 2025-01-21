"
A Pharo AST visitor used internally to compute the callgraph of nodes.

See `CoverageCollector>>#callgraph` for details.
"
Class {
	#name : 'C2SequenceGraphVisitor',
	#superclass : 'RBProgramNodeVisitor',
	#instVars : [
		'edges',
		'currentNode',
		'collector'
	],
	#category : 'Coverage2',
	#package : 'Coverage2'
}

{ #category : 'accessing' }
C2SequenceGraphVisitor >> collector [

	^ collector
]

{ #category : 'accessing' }
C2SequenceGraphVisitor >> collector: anObject [

	collector := anObject
]

{ #category : 'accessing' }
C2SequenceGraphVisitor >> edges [

	^ edges
]

{ #category : 'accessing' }
C2SequenceGraphVisitor >> edges: anObject [

	edges := anObject
]

{ #category : 'initialization' }
C2SequenceGraphVisitor >> initialize [

	edges := OrderedCollection new.
]

{ #category : 'visiting' }
C2SequenceGraphVisitor >> visitMessageNode: aMessageNode [

	"Visit recusively"
	super visitMessageNode: aMessageNode.

	"And add an adge to all "
	collector methods
		select: [ :m | m selector = aMessageNode selector ]
		thenDo: [ :m |
			| target |
			target := m ast body.
			self assert: target isSequence.
			edges add: { currentNode. target }. ].

]

{ #category : 'visiting' }
C2SequenceGraphVisitor >> visitSequenceNode: aSequenceNode [

	"Dot not visit sub-sequences, just mark an edge"
	currentNode ifNotNil: [
		edges add: { currentNode. aSequenceNode }.
		^ self ].
	
	currentNode := aSequenceNode.
	super visitSequenceNode: aSequenceNode.
	currentNode := nil.


]
