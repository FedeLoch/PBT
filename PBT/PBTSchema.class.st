Class {
	#name : 'PBTSchema',
	#superclass : 'Object',
	#instVars : [
		'assert',
		'argumentConstraints',
		'receiverConstraint',
		'score',
		'feedbackEvaluator'
	],
	#category : 'PBT-Property Schema',
	#package : 'PBT',
	#tag : 'Property Schema'
}

{ #category : 'ston-core' }
PBTSchema class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( #assert #score )
]

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

{ #category : 'accessing' }
PBTSchema >> feedbackEvaluator [

	^ feedbackEvaluator
]

{ #category : 'accessing' }
PBTSchema >> guidedBy: aBlock [

	feedbackEvaluator := FeedbackEvaluator from: aBlock
]

{ #category : 'accessing' }
PBTSchema >> guidedByAllocatedMemory [

	self guidedBy: [ :test | test result allocatedMemory ]
]

{ #category : 'accessing' }
PBTSchema >> guidedByCoverage [

	self guidedBy: [ :test | test result coverageResult percentage ]
]

{ #category : 'accessing' }
PBTSchema >> guidedByExecutionTime [

	self guidedBy: [ :test | test time asMilliSeconds ]
]

{ #category : 'accessing' }
PBTSchema >> guidedByScore [

	self guidedBy: [ :test | test score ]
]

{ #category : 'initialization' }
PBTSchema >> initialize [ 

	super initialize.
	argumentConstraints := #().
	receiverConstraint := nil.
	self guidedByCoverage
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

{ #category : 'accessing' }
PBTSchema >> score [

	^ score
]

{ #category : 'accessing' }
PBTSchema >> score: aBlock [

	score := aBlock 
]
