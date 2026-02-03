Class {
	#name : 'UmeJSONTest',
	#superclass : 'UmeFrameworkTest',
	#instVars : [
		'receiverConstraint',
		'argumentConstraints',
		'schema'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeJSONTest >> jsonGenerator [

	self subclassResponsibility 
]

{ #category : 'running' }
UmeJSONTest >> setUp [

	super setUp.
	self timeLimit: 5 hours.

	receiverConstraint := UmeObjectConstraint new generator: (UmeConstantGenerator new value: NeoJSONReader).

	argumentConstraints := { UmeObjectConstraint new objectClass: String; generator: self jsonGenerator }.

	schema := UmeSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          score: [ :re :inputs :res | 1 ];
		          assert: [ :regex :input :result | true ].
]
