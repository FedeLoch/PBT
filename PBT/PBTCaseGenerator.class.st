Class {
	#name : 'PBTCaseGenerator',
	#superclass : 'Object',
	#instVars : [
		'schema'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> feed: caseFeedback [
	
	self feedReceiverGenerator: caseFeedback.
	self feedArgumentsGenerators: caseFeedback
]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> feedArgumentsGenerators: caseFeedback [

	schema argumentConstraints collectWithIndex: [ :inputConstraint :index |
		inputConstraint feed: (caseFeedback argumentFeedbackCase: index)
	]
]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> feedReceiverGenerator: caseFeedback [

	schema receiverConstraint feed: (caseFeedback receiverFeedback)
]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> genArgumentsFor: target from: aSchema [
	
	self schema: aSchema.
	
	^ schema argumentConstraints collect: [ :inputConstraint |
		self genInstanceFor: inputConstraint
	]

]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> genInstanceFor: constraint [
	
	^ constraint gen
]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> genReceiverFor: target from: aSchema [

	self schema: aSchema.
	
	^ self genInstanceFor: schema receiverConstraint
]

{ #category : 'as yet unclassified' }
PBTCaseGenerator >> schema: aSchema [

	schema := aSchema 
]
