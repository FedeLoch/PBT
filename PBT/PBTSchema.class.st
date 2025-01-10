Class {
	#name : 'PBTSchema',
	#superclass : 'Object',
	#instVars : [
		'assert',
		'argumentConstraints',
		'receiverConstraint'
	],
	#category : 'PBT-Property Schema',
	#package : 'PBT',
	#tag : 'Property Schema'
}

{ #category : 'accessing' }
PBTSchema >> argumentConstraints [

	^ argumentConstraints 
]

{ #category : 'accessing' }
PBTSchema >> argumentConstraints: anArgumentConstraints [

	argumentConstraints := anArgumentConstraints.
]

{ #category : 'accessing' }
PBTSchema >> assert [

	^ assert
]

{ #category : 'accessing' }
PBTSchema >> assert: anAssertBlock [

	assert := anAssertBlock
]

{ #category : 'initialization' }
PBTSchema >> initialize [ 

	super initialize.
	argumentConstraints := #().
	receiverConstraint := nil.
]

{ #category : 'accessing' }
PBTSchema >> merge: anotherSchema [

	self mergeReceiverConstraint: anotherSchema receiverConstraint.
	self mergeArgumentConstraint: anotherSchema argumentConstraints.
	self mergeAssert: anotherSchema assert. 
	"TODO:
		Think how to index the schema, for the moment the schema respect the next structure:
		{
			objectConstraint: Constraint,
			inputConstraints: [ Constraint ],
			assert: Block
		},
		But maybe the best structure could be:
		{
			[ Class/Type ]: {
				objectConstraint: Constraint,
				methods: {
					[ method ]: { inputsConstraint: [ Constraint ], assert: aBlock }
				}
			}
		}
		
		A Constraint looks as follow:
		{
			objectClass: Class, gen: aBlock, props: { variable: Class }
		}
	"
	^ self
]

{ #category : 'accessing' }
PBTSchema >> mergeArgumentConstraint: someArgumentConstraints [

	argumentConstraints ifNil: [ ^ argumentConstraints := someArgumentConstraints ].

]

{ #category : 'accessing' }
PBTSchema >> mergeAssert: anAssert [

	assert ifNil: [ ^ assert := anAssert ].
]

{ #category : 'accessing' }
PBTSchema >> mergeReceiverConstraint: aReceiverConstraint [

	receiverConstraint ifNil: [ receiverConstraint := aReceiverConstraint ].
]

{ #category : 'accessing' }
PBTSchema >> receiverConstraint [

	^ receiverConstraint
]

{ #category : 'accessing' }
PBTSchema >> receiverConstraint: aReceiverConstraint [

	receiverConstraint := aReceiverConstraint.
]
