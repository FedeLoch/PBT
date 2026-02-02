Class {
	#name : 'UmeMicrodownGrammarWithWeightsTest',
	#superclass : 'UmeMicrodownTest',
	#instVars : [
		'runner'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeMicrodownGrammarWithWeightsTest >> markdownGenerator [

	^ PBTGrammarGenerator new grammar: ExtendedMarkdownGrammar new; maxSize: 200
]

{ #category : 'running' }
UmeMicrodownGrammarWithWeightsTest >> setUp [

	super setUp.
	runner := PBTRunner test: Microdown class >> #parse: from: schema for: 5 minutes.
]

{ #category : 'tests' }
UmeMicrodownGrammarWithWeightsTest >> testGuidingByMethodsCalls [ 

	| result |
	runner guidedByMethodsCalls.
	result := runner run.
	1 halt.
]
