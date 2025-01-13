Class {
	#name : 'IncrementalCoverageResult',
	#superclass : 'CoverageResult',
	#category : 'PBT-Result',
	#package : 'PBT',
	#tag : 'Result'
}

{ #category : 'instance creation' }
IncrementalCoverageResult class >> for: methods [

	^ self new methods: methods; nodes: IdentitySet new 
]

{ #category : 'as yet unclassified' }
IncrementalCoverageResult >> asPercent [
	collector ifNil: [ ^0 ].
	^ self percentage
]

{ #category : 'as yet unclassified' }
IncrementalCoverageResult >> incrementWith: anotherResult [
	"Merge covered nodes"
	nodes := nodes, anotherResult nodes.
	"Naive, this assumes that we are being instrumenting the same set of methods"
	collector ifNil: [ collector := anotherResult collector ]
]
