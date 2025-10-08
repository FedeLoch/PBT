Class {
	#name : 'PBTJSONTest',
	#superclass : 'PBTFrameworkTest',
	#instVars : [
		'receiverConstraint',
		'argumentConstraints',
		'schema'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTJSONTest >> jsonGenerator [

	self subclassResponsibility 
]

{ #category : 'running' }
PBTJSONTest >> setUp [

	super setUp.
	self timeLimit: 5 hours.

	receiverConstraint := PBTObjectConstraint new generator: (PBTConstantGenerator new value: NeoJSONReader).

	argumentConstraints := { PBTObjectConstraint new objectClass: String; generator: self jsonGenerator }.

	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          score: [ :re :inputs :res | 1 ];
		          assert: [ :regex :input :result | true ].
]
