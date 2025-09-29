Class {
	#name : 'PBTCaseGenerator',
	#superclass : 'Object',
	#instVars : [
		'lastReceiver',
		'lastArguments',
		'schema'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> feed: improvementFeedback [
	
	self feedReceiverGenerator: improvementFeedback.
	self feedArgumentsGenerators: improvementFeedback
]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> feedArgumentsGenerators: improvementFeedback [

	schema argumentConstraints collectWithIndex: [ :inputConstraint :index |
		inputConstraint feed: (PBTFeedback from: (self lastArgument: index) improvement: improvementFeedback)
	]
]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> feedReceiverGenerator: improvementFeedback [

	schema receiverConstraint feed: (PBTFeedback from: lastReceiver improvement: improvementFeedback)
]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> genArgumentsFor: target from: aSchema [
	
	self schema: aSchema.
	
	lastArguments := schema argumentConstraints collect: [ :inputConstraint |
		self genInstanceFor: inputConstraint
	].

	^ lastArguments

]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> genInstanceFor: constraint [
	
	^ constraint gen
]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> genReceiverFor: target from: aSchema [

	self schema: aSchema.
	
	lastReceiver := self genInstanceFor: schema receiverConstraint.
	
	^ lastReceiver
]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> lastArgument: index [

	^ lastArguments ifNil: [ nil ] ifNotNil: [ lastArguments at: index ] 
]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> schema: aSchema [

	schema := aSchema 
]
