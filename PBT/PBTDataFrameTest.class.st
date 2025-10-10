Class {
	#name : 'PBTDataFrameTest',
	#superclass : 'PBTFrameworkTest',
	#instVars : [
		'schema'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTDataFrameTest >> csvGenerator [

	self subclassResponsibility 
]

{ #category : 'running' }
PBTDataFrameTest >> setUp [

	super setUp.
	self timeLimit: 5 hours.

	schema := PBTSchema new
		          receiverConstraint: (PBTObjectConstraint new generator: (PBTConstantGenerator new value: DataFrame));
		          argumentConstraints: { PBTObjectConstraint new objectClass: String; generator: self csvGenerator };
		          score: [ :re :inputs :res | 1 ];
		          assert: [ :regex :input :result | true ].
]
