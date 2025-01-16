Class {
	#name : 'PBTRunnerSimplerBlocBenchsTest',
	#superclass : 'PBTRunnerBlocBenchsTest',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRunnerSimplerBlocBenchsTest >> setUp [

	super setUp.

	receiverConstraint := PBTObjectConstraint new
		                      objectClass: BlBBlocPBTCase;
		                      generator:
			                      (PBTGenerator onceInstance: [ :testCase :props |
												testCase runner meters: (OrderedCollection with: BlBBlocRenderingMeter new).
												testCase element: (props at: 'element') gen.
												testCase duration: 500 milliSeconds.
												testCase ]
										);
		                      props: { ('element' -> self blElementConstraint) }.

	assert := [ :coll :args :blbResult | blbResult hasError not ].
	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          assert: assert
]

{ #category : 'tests' }
PBTRunnerSimplerBlocBenchsTest >> testGivingASimplerBlocBenchSchemaThenGenerateCasesToAnalyseCoverageAndPerformance [

	| pbtResult |

	self timeLimit: 5 minutes.
	pbtResult := PBTRunner test: BlBCase >> #run from: schema times: 10.

	1 halt.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 10.
]
