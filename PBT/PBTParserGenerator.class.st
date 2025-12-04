Class {
	#name : 'PBTParserGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'inputGenerator'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
PBTParserGenerator class >> from: grammarInputGenerator [

	^ self new inputGenerator: grammarInputGenerator
]

{ #category : 'as yet unclassified' }
PBTParserGenerator >> feed: feedback [

	inputGenerator feed: feedback 
]

{ #category : 'as yet unclassified' }
PBTParserGenerator >> gen: myConstraint [

	^ self parse: (inputGenerator gen: myConstraint)
]

{ #category : 'accessing' }
PBTParserGenerator >> inputGenerator [

	^ inputGenerator
]

{ #category : 'accessing' }
PBTParserGenerator >> inputGenerator: generator [

	inputGenerator := generator
]

{ #category : 'as yet unclassified' }
PBTParserGenerator >> parse: grammarBasedInput [

	self subclassResponsibility 
]
