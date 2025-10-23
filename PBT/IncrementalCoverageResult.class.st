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
IncrementalCoverageResult class >> for: methods from: collector [

	^ self new methods: methods asSet; nodes: IdentitySet new ; collector: collector
]

{ #category : 'ston-core' }
IncrementalCoverageResult class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( methods )
]

{ #category : 'as yet unclassified' }
IncrementalCoverageResult >> asPercent [
	^ self percentage
]

{ #category : 'as yet unclassified' }
IncrementalCoverageResult >> hasMethod: aMethod [

	^ methodNames includes: aMethod name
]

{ #category : 'as yet unclassified' }
IncrementalCoverageResult >> hasNewMethods: someMethods [

	| newMethods | 
	
	newMethods := someMethods reject: [ :method | self hasMethod: method ].

	^ newMethods isNotEmpty 
]

{ #category : 'as yet unclassified' }
IncrementalCoverageResult >> hasNewNodes: someNodes [

	| newNodes |

	newNodes := someNodes reject: [ :node | nodes includes: node ].

	^ newNodes isNotEmpty
]

{ #category : 'as yet unclassified' }
IncrementalCoverageResult >> increaseCoverage: coverage [

	coverage ifNil: [ ^ false ].

	^ (self hasNewMethods: coverage methods) or: [ self hasNewNodes: coverage nodes ]
]

{ #category : 'as yet unclassified' }
IncrementalCoverageResult >> incrementWith: anotherResult [

	anotherResult ifNil: [ ^ self ].

	"Merge covered nodes"
	nodes := nodes, anotherResult nodes.
	self mergeMethods: anotherResult methods.
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
