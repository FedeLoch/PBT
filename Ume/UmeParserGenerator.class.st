Class {
	#name : 'UmeParserGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'inputGenerator',
		'parseBlock'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
UmeParserGenerator class >> from: grammarInputGenerator [

	^ self new inputGenerator: grammarInputGenerator
]

{ #category : 'instance creation' }
UmeParserGenerator class >> from: grammarInputGenerator do: aBlock [

	^ self new inputGenerator: grammarInputGenerator; parseBlock: aBlock
]

{ #category : 'as yet unclassified' }
UmeParserGenerator >> feed: feedback [

	inputGenerator feed: feedback 
]

{ #category : 'as yet unclassified' }
UmeParserGenerator >> gen: myConstraint [

	^ self parse: (inputGenerator gen: myConstraint)
]

{ #category : 'accessing' }
UmeParserGenerator >> inputGenerator [

	^ inputGenerator
]

{ #category : 'accessing' }
UmeParserGenerator >> inputGenerator: generator [

	inputGenerator := generator
]

{ #category : 'as yet unclassified' }
UmeParserGenerator >> parse: grammarBasedInput [
	
	parseBlock ifNotNil: [ ^ parseBlock value: grammarBasedInput ].
	
	^ Error new
]

{ #category : 'as yet unclassified' }
UmeParserGenerator >> parseBlock: block [

	parseBlock := block 
]
