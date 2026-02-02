Class {
	#name : 'UmeSimplerBlocBenchsTest',
	#superclass : 'UmeBlocBenchsTest',
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeSimplerBlocBenchsTest >> setUp [

	super setUp.

	receiverConstraint := PBTObjectConstraint new
		                      generator:
			                      (UmeGenerator onceInstance: [ :testCase :props |
												"testCase runner meters: (OrderedCollection with: BlBBlocRenderingMeter new)."
												testCase element: (props at: 'element') gen.
												testCase duration: 500 milliSeconds.
												testCase ] of: BlBBlocPBTCase
										);
		                      props: { ('element' -> self blElementConstraint) }.

	assert := [ :coll :args :blbResult | blbResult hasError not ].
	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          assert: assert
]

{ #category : 'tests' }
UmeSimplerBlocBenchsTest >> testGivingASimplerBlocBenchSchemaThenGenerateCasesToAnalyseCoverageAndPerformance [

	| pbtResult |

	self timeLimit: 5 minutes.
	pbtResult := (PBTRunner test: BlBCase >> #run from: schema times: 10) run.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 10.
]
