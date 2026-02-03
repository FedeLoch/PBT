Class {
	#name : 'UmeParserGenerator',
	#superclass : 'UmeGenerator',
	#instVars : [
		'inputGenerator'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'instance creation' }
UmeParserGenerator class >> from: grammarInputGenerator [

	^ self new inputGenerator: grammarInputGenerator
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

	self subclassResponsibility 
]
