Class {
	#name : 'IncrementalCoverageResult',
	#superclass : 'CoverageResult',
	#instVars : [
		'methodNames'
	],
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
IncrementalCoverageResult >> hasMethod: aMethod [

	^ methodNames includes: aMethod name
]

{ #category : 'as yet unclassified' }
IncrementalCoverageResult >> incrementWith: anotherResult [

	"Merge covered nodes"
	nodes := nodes, anotherResult nodes.
	self mergeMethods: anotherResult methods.
	
	collector ifNil: [ collector := anotherResult collector ]
]

{ #category : 'as yet unclassified' }
IncrementalCoverageResult >> mergeMethods: someMethods [

	| newMethods |
	
	newMethods := someMethods reject: [ :method | self hasMethod: method ].
	methods := methods, newMethods.
	methodNames := methodNames, (newMethods collect: #name).
]

{ #category : 'as yet unclassified' }
IncrementalCoverageResult >> methods: someMethods [

	super methods: someMethods.
	methodNames := (methods collect: #name) asSet
]
