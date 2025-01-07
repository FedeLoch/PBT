Class {
	#name : 'PBTInputGenerator',
	#superclass : 'Object',
	#category : 'PBT-Input Generation',
	#package : 'PBT',
	#tag : 'Input Generation'
}

{ #category : 'as yet unclassified' }
PBTInputGenerator >> genInputsFor: target from: schema [

	schema inputConstraints ifNil: [ ^#() ].
	1 halt.
	"TODO: Implement me"
]

{ #category : 'as yet unclassified' }
PBTInputGenerator >> genObjectFor: target from: schema [
	
	"Considerar una seed"
	^ schema objectConstraint generator gen
]
