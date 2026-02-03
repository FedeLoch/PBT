Class {
	#name : 'UmeCaseGenerator',
	#superclass : 'Object',
	#instVars : [
		'schema'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'as yet unclassified' }
UmeCaseGenerator >> feed: caseFeedback [
	
	self feedReceiverGenerator: caseFeedback.
	self feedArgumentsGenerators: caseFeedback
]

{ #category : 'as yet unclassified' }
UmeCaseGenerator >> feedArgumentsGenerators: caseFeedback [

	schema argumentConstraints collectWithIndex: [ :inputConstraint :index |
		inputConstraint feed: (caseFeedback argumentFeedbackCase: index)
	]
]

{ #category : 'as yet unclassified' }
UmeCaseGenerator >> feedReceiverGenerator: caseFeedback [

	schema receiverConstraint feed: (caseFeedback receiverFeedback)
]

{ #category : 'as yet unclassified' }
UmeCaseGenerator >> genArgumentsFor: target from: aSchema [
	
	self schema: aSchema.
	
	^ schema argumentConstraints collect: [ :inputConstraint |
		self genInstanceFor: inputConstraint
	]

]

{ #category : 'as yet unclassified' }
UmeCaseGenerator >> genInstanceFor: constraint [
	
	^ constraint gen
]

{ #category : 'as yet unclassified' }
UmeCaseGenerator >> genReceiverFor: target from: aSchema [

	self schema: aSchema.
	
	^ self genInstanceFor: schema receiverConstraint
]

{ #category : 'as yet unclassified' }
UmeCaseGenerator >> schema: aSchema [

	schema := aSchema 
]
