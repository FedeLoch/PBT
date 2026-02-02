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
						                       generator: UmePointGenerator new)).
				                     ('corner' -> (UmeObjectConstraint new
					                       generator: UmePointGenerator new)) }.
	argumentConstraints := {  }.
	assert := [ :rect :args :result | result >= 0 ].
	schema := UmeSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          assert: assert
]

{ #category : 'as yet unclassified' }
UmeRectangleAreaTest >> testGivingASmallIntegerSchemaThenValidatePlusResult [

	| result |

	result := (UmeRunner test: Rectangle >> #area from: schema times: 1000) run.
	
	self assertSuccess: result.
	self assert: (result tests size) equals: 1000.
]

{ #category : 'as yet unclassified' }
UmeRectangleAreaTest >> testGivingASmallIntegerSchemaThenValidatePlusResultWithCoverageChangeTolerance [

	| result |

	result := (UmeRunner test: Rectangle >> #area from: schema withCoverageTolerance: 1000) run.

	self assertSuccess: result.
	self assert: (result totalCoverage percentage) equals: 100. 
	self assert: (result tests size < 1000) equals: true.
]
