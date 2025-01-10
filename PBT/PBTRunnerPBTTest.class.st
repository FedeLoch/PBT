Class {
	#name : 'PBTRunnerPBTTest',
	#superclass : 'PBTRunnerTest',
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
PBTRunnerPBTTest >> setUp [

	| generator |
	super setUp.

	generator := PBTGenerator onceInstance: [ :instance :props | PBTRunner ].

	receiverConstraint := PBTObjectConstraint new
		                     objectClass: PBTRunner;
		                     generator: generator;
		                     props: {}.
	
	argumentConstraints := { PBTObjectConstraint new
		                     objectClass: CompiledMethod;
		                     generator: (PBTGenerator oneOf: Object allMethods);
		                     props: {}
	}.
	
	assert := [ :method :args :result | self assertSuccess: result ].
	
	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          assert: assert
]

{ #category : 'as yet unclassified' }
PBTRunnerPBTTest >> testGivingThePBTRunnerSchemaThenValidatePBTFramework [

	"This test has the intention to prove the framework itself"
	"TODO: Not executable until we support schema inference"
	| pbtResult |

	pbtResult := PBTRunner test: PBTRunner class>>#test: from: schema times: 1000.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 1000.
]
