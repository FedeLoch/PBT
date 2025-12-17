Class {
	#name : 'PBTJSONGrammarWithWeightsTest',
	#superclass : 'PBTJSONTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTJSONGrammarWithWeightsTest >> jsonGenerator [

	^ PBTGrammarGenerator new grammar: JSONGrammar new; maxSize: 100
]

{ #category : 'tests' }
PBTJSONGrammarWithWeightsTest >> setUp [ 

	super setUp.
	runner := PBTRunner test: NeoJSONReader class >> #fromString: from: schema for: 10 minutes.

]

{ #category : 'tests' }
PBTJSONGrammarWithWeightsTest >> testGuidingByMethodsCalls [ 

	| result |
	
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
	
]
