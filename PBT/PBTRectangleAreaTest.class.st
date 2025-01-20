Class {
	#name : 'PBTRectangleAreaTest',
	#superclass : 'PBTFrameworkTest',
	#instVars : [
		'receiverConstraint',
		'assert',
		'schema',
		'argumentConstraints'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRectangleAreaTest >> setUp [

	| generator |
	super setUp.

	generator := PBTGenerator onceInstance: [ :instance :props |
		             instance
			             setPoint: (props at: 'origin') gen
			             point: (props at: 'corner') gen.
		             instance ].

	receiverConstraint := PBTObjectConstraint new
		                     objectClass: Rectangle;
		                     generator: generator;
		                     props: {
				                     ('origin' -> (PBTObjectConstraint new
						                       objectClass: Point;
						                       generator: PBTPointGenerator new)).
				                     ('corner' -> (PBTObjectConstraint new
					                       objectClass: Point;
					                       generator: PBTPointGenerator new)) }.
	argumentConstraints := {  }.
	assert := [ :rect :args :result | result >= 0 ].
	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          assert: assert
]

{ #category : 'as yet unclassified' }
PBTRectangleAreaTest >> testGivingASmallIntegerSchemaThenValidatePlusResult [

	| pbtResult |

	pbtResult := PBTRunner test: Rectangle >> #area from: schema times: 1000.
	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 1000.
]

{ #category : 'as yet unclassified' }
PBTRectangleAreaTest >> testGivingASmallIntegerSchemaThenValidatePlusResultWithCoverageChangeTolerance [

	| pbtResult |

	pbtResult := PBTRunner test: Rectangle >> #area from: schema withCoverageTolerance: 1000.

	self assertSuccess: pbtResult.
	self assert: (pbtResult totalCoverage percentage) equals: 100. 
	self assert: (pbtResult tests size < 1000) equals: true.
]
