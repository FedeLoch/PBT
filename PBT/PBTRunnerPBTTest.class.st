Class {
	#name : 'PBTRunnerPBTTest',
	#superclass : 'PBTRunnerTest',
	#instVars : [
		'objectConstraints',
		'assert',
		'schema',
		'inputConstraints'
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

	objectConstraints := PBTObjectConstraint new
		                     objectClass: PBTRunner;
		                     generator: generator;
		                     props: {}.
	
	inputConstraints := { PBTObjectConstraint new
		                     objectClass: CompiledMethod;
		                     generator: (PBTGenerator oneOf: Object allMethods);
		                     props: {}
	}.
	
	assert := [ :method :args :result | self assertSuccess: result ].
	
	schema := PBTSchema new
		          objectConstraint: objectConstraints;
		          inputConstraints: inputConstraints;
		          assert: assert
]

{ #category : 'tests' }
PBTRunnerPBTTest >> testGivingThePBTRunnerSchemaThenValidatePBTFramework [

	"This test has the intention to prove the framework itself"
	"TODO: Not executable until we support schema inference"
	| pbtResult |

	pbtResult := PBTRunner test: PBTRunner class>>#test: from: schema times: 1000.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 1000.
]
