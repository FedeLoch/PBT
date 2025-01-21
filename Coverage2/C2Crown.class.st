"
I represent an not fully visided selector in a core result.

For a given `selector`, I associate callers that are call sites (`RBSendNode`) in covered methods to callees that are uncovered methods (`CompiledMethod`).
"
Class {
	#name : 'C2Crown',
	#superclass : 'Object',
	#instVars : [
		'selector',
		'callees',
		'callers'
	],
	#category : 'Coverage2',
	#package : 'Coverage2'
}

{ #category : 'accessing' }
C2Crown >> callees [

	^ callees
]

{ #category : 'accessing' }
C2Crown >> callers [

	^ callers
]

{ #category : 'initialization' }
C2Crown >> initialize [

	callees := OrderedCollection new.
	callers := OrderedCollection new
]

{ #category : 'printing' }
C2Crown >> printOn: aStream [

	super printOn: aStream.
	aStream print: selector.
	aStream
		nextPutAll: ' callers: ';
		print: callers size.
	aStream
		nextPutAll: ' callees: ';
		print: callees size.

]

{ #category : 'accessing' }
C2Crown >> selector [

	^ selector
]

{ #category : 'accessing' }
C2Crown >> selector: anObject [

	selector := anObject
]
