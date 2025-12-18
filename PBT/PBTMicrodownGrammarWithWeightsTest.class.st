Class {
	#name : 'PBTMicrodownGrammarWithWeightsTest',
	#superclass : 'PBTMicrodownTest',
	#instVars : [
		'runner'
	],
	#category : 'PBT-Framework Tests',
	#package : 'PBT',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
PBTMicrodownGrammarWithWeightsTest >> markdownGenerator [

	^ PBTGrammarGenerator new grammar: ExtendedMarkdownGrammar new; maxSize: 200
]

{ #category : 'running' }
PBTMicrodownGrammarWithWeightsTest >> setUp [

	super setUp.
	runner := PBTRunner test: Microdown class >> #parse: from: schema for: 5 minutes.
]

{ #category : 'tests' }
PBTMicrodownGrammarWithWeightsTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
