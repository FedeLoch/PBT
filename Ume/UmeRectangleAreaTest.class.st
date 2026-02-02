Class {
	#name : 'UmeRectangleAreaTest',
	#superclass : 'UmeFrameworkTest',
	#instVars : [
		'receiverConstraint',
		'assert',
		'schema',
		'argumentConstraints'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeRectangleAreaTest >> setUp [

	| generator |
	super setUp.

	generator := UmeGenerator onceInstance: [ :instance :props |
		             instance
			             setPoint: (props at: 'origin') gen
			             point: (props at: 'corner') gen.
		             instance ] of: Rectangle.

	receiverConstraint := UmeObjectConstraint new
		                     generator: generator;
		                     props: {
				                     ('origin' -> (UmeObjectConstraint new
						                       generator: PBTPointGenerator new)).
				                     ('corner' -> (UmeObjectConstraint new
					                       generator: PBTPointGenerator new)) }.
	argumentConstraints := {  }.
	assert := [ :rect :args :result | result >= 0 ].
	schema := UmeSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          assert: assert
]

{ #category : 'as yet unclassified' }
UmeRectangleAreaTest >> testGivingASmallIntegerSchemaThenValidatePlusResult [

	| pbtResult |

	pbtResult := (UmeRunner test: Rectangle >> #area from: schema times: 1000) run.
	
	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 1000.
]

{ #category : 'as yet unclassified' }
UmeRectangleAreaTest >> testGivingASmallIntegerSchemaThenValidatePlusResultWithCoverageChangeTolerance [

	| pbtResult |

	pbtResult := (UmeRunner test: Rectangle >> #area from: schema withCoverageTolerance: 1000) run.

	self assertSuccess: pbtResult.
	self assert: (pbtResult totalCoverage percentage) equals: 100. 
	self assert: (pbtResult tests size < 1000) equals: true.
]
