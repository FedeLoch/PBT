Class {
	#name : 'PBTSchema',
	#superclass : 'Object',
	#instVars : [
		'objectConstraint',
		'inputConstraints',
		'assert'
	],
	#category : 'PBT-Property Schema',
	#package : 'PBT',
	#tag : 'Property Schema'
}

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
	inputConstraints := #().
	objectConstraint := nil.
]

{ #category : 'accessing' }
PBTSchema >> inputConstraints [

	^ inputConstraints 
]

{ #category : 'accessing' }
PBTSchema >> inputConstraints: anInputConstraints [

	inputConstraints := anInputConstraints.
]

{ #category : 'accessing' }
PBTSchema >> merge: anotherSchema [

	self mergeObjectConstraint: anotherSchema objectConstraint.
	self mergeInputConstraint: anotherSchema inputConstraints.
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
PBTSchema >> mergeAssert: anAssert [

	assert ifNil: [ ^ assert := anAssert ].
]

{ #category : 'accessing' }
PBTSchema >> mergeInputConstraint: someInputConstraints [

	inputConstraints ifNil: [ ^ inputConstraints := someInputConstraints ].

]

{ #category : 'accessing' }
PBTSchema >> mergeObjectConstraint: anObjectConstraint [

	objectConstraint ifNil: [ objectConstraint := anObjectConstraint ].
]

{ #category : 'accessing' }
PBTSchema >> objectConstraint [

	^ objectConstraint
]

{ #category : 'accessing' }
PBTSchema >> objectConstraint: aObjectConstraint [

	objectConstraint := aObjectConstraint.
]
