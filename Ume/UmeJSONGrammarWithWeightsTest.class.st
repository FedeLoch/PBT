Class {
	#name : 'UmeJSONGrammarWithWeightsTest',
	#superclass : 'UmeJSONTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeJSONGrammarWithWeightsTest >> jsonGenerator [

	^ UmeGrammarGenerator new grammar: JSONGrammar new; maxSize: 100
]

{ #category : 'tests' }
UmeJSONGrammarWithWeightsTest >> setUp [ 

	super setUp.
	runner := UmeRunner test: NeoJSONReader class >> #fromString: from: schema for: 10 minutes.

]

{ #category : 'tests' }
UmeJSONGrammarWithWeightsTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
