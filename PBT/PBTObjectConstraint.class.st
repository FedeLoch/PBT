Class {
	#name : 'PBTObjectConstraint',
	#superclass : 'Object',
	#instVars : [
		'objectClass',
		'generator',
		'props',
		'wrapBlock',
		'unwrapBlock'
	],
	#category : 'PBT-Property Schema',
	#package : 'PBT',
	#tag : 'Property Schema'
}

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> feed: pbtFeedback [
	
	| unwrappedFeedback |
	
	unwrappedFeedback := pbtFeedback ifNil: [ pbtFeedback ] ifNotNil: [ pbtFeedback unWrapCase: unwrapBlock ].
	generator feed: unwrappedFeedback
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> gen [

	^ self wrapInput: (generator gen: self)
]

{ #category : 'accessing' }
PBTObjectConstraint >> generator [

	^ generator 
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> generator: aBlock [

	generator := aBlock
]

{ #category : 'accessing' }
PBTObjectConstraint >> objectClass [

	^ objectClass 
]

{ #category : 'accessing' }
PBTObjectConstraint >> objectClass: aClass [

	objectClass := aClass 
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> props [
	
	^ props
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> props: aPropObj [

	props := aPropObj class = InternalConstraintProperties
		         ifTrue: [ aPropObj ]
		         ifFalse: [ InternalConstraintProperties from: aPropObj asDictionary ]
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> unwrap: block [

	unwrapBlock := block
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> wrap: block [

	wrapBlock := block
]

{ #category : 'as yet unclassified' }
PBTObjectConstraint >> wrapInput: input [

	wrapBlock ifNil: [ ^ input ].
	
	^ wrapBlock value: input
]
