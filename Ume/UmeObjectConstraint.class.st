Class {
	#name : 'UmeObjectConstraint',
	#superclass : 'Object',
	#instVars : [
		'objectClass',
		'generator',
		'props',
		'wrapBlock',
		'unwrapBlock'
	],
	#category : 'Ume-Property Schema',
	#package : 'Ume',
	#tag : 'Property Schema'
}

{ #category : 'as yet unclassified' }
UmeObjectConstraint >> feed: pbtFeedback [
	
	| unwrappedFeedback |
	
	unwrappedFeedback := pbtFeedback ifNil: [ pbtFeedback ] ifNotNil: [ pbtFeedback unWrapCase: unwrapBlock ].
	generator feed: unwrappedFeedback
]

{ #category : 'as yet unclassified' }
UmeObjectConstraint >> gen [

	^ self wrapInput: (generator gen: self)
]

{ #category : 'accessing' }
UmeObjectConstraint >> generator [

	^ generator 
]

{ #category : 'as yet unclassified' }
UmeObjectConstraint >> generator: aBlock [

	generator := aBlock
]

{ #category : 'accessing' }
UmeObjectConstraint >> objectClass [

	^ objectClass 
]

{ #category : 'accessing' }
UmeObjectConstraint >> objectClass: aClass [

	objectClass := aClass 
]

{ #category : 'as yet unclassified' }
UmeObjectConstraint >> props [
	
	^ props
]

{ #category : 'as yet unclassified' }
UmeObjectConstraint >> props: aPropObj [

	props := aPropObj class = UmeInternalConstraintProperties
		         ifTrue: [ aPropObj ]
		         ifFalse: [ UmeInternalConstraintProperties from: aPropObj asDictionary ]
]

{ #category : 'as yet unclassified' }
UmeObjectConstraint >> unwrap: block [

	unwrapBlock := block
]

{ #category : 'as yet unclassified' }
UmeObjectConstraint >> wrap: block [

	wrapBlock := block
]

{ #category : 'as yet unclassified' }
UmeObjectConstraint >> wrapInput: input [

	wrapBlock ifNil: [ ^ input ].
	
	^ wrapBlock value: input
]
