Class {
	#name : 'IncrementalCoverageResult',
	#superclass : 'CoverageResult',
	#category : 'PBT-Result',
	#package : 'PBT',
	#tag : 'Result'
}

{ #category : 'instance creation' }
IncrementalCoverageResult class >> for: methods [

	^ self new methods: methods asSet; nodes: IdentitySet new 
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
	anotherResult methods do: [ :method |
		((methods collect: #name) includes: method name) ifFalse: [ methods add: method ] ].
	
	collector ifNil: [ collector := anotherResult collector ]
]
