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

	receiverConstraint := UmeObjectConstraint new
		                      generator:
			                      (UmeGenerator onceInstance: [ :testCase :props |
												"testCase runner meters: (OrderedCollection with: BlBBlocRenderingMeter new)."
												testCase element: (props at: 'element') gen.
												testCase duration: 500 milliSeconds.
												testCase ] of: BlBBlocUmeCase
										);
		                      props: { ('element' -> self blElementConstraint) }.

	assert := [ :coll :args :blbResult | blbResult hasError not ].
	schema := UmeSchema new
		          receiverConstraint: receiverConstraint;
		          assert: assert
]

{ #category : 'tests' }
UmeSimplerBlocBenchsTest >> testGivingASimplerBlocBenchSchemaThenGenerateCasesToAnalyseCoverageAndPerformance [

	| result |

	self timeLimit: 5 minutes.
	result := (UmeRunner test: BlBCase >> #run from: schema times: 10) run.

	self assertSuccess: result.
	self assert: (result tests size) equals: 10.
]
