Class {
	#name : 'PBTSchema',
	#superclass : 'Object',
	#instVars : [
		'objectConstraint',
		'inputConstraints',
		'assert'
	],
	#category : 'PBT-Property Specifcation',
	#package : 'PBT',
	#tag : 'Property Specifcation'
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
PBTSchema >> objectConstraint [

	^ objectConstraint
]

{ #category : 'accessing' }
PBTSchema >> objectConstraint: aObjectConstraint [

	objectConstraint := aObjectConstraint.
]
