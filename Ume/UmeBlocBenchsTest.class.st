Class {
	#name : 'UmeBlocBenchsTest',
	#superclass : 'UmeFrameworkTest',
	#instVars : [
		'schema',
		'receiverConstraint',
		'assert'
	],
	#category : 'Ume-Framework Tests',
	#package : 'Ume',
	#tag : 'Framework Tests'
}

{ #category : 'running' }
UmeBlocBenchsTest >> blChildConstraint [

	^ UmeObjectConstraint new
		  generator: (UmeGenerator onceInstance: [ :element :props |
					   element
						   background: (props at: 'color') gen;
						   height: 50;
						   width: 50.
					   element layout: (BlGridLayout new columnCount: 10).
					   element layout cellSpacing: 0.
					   element addChildren: ((1 to: 200) collect: [ :i |
							    BlElement new
								    background: (props at: 'color') gen;
								    height: 5;
								    width: 5 ]).
					   element ] of: BlElement);
		  props: { ('color' -> self blColorConstraint) }
]

{ #category : 'running' }
UmeBlocBenchsTest >> blColorConstraint [

	^ UmeObjectConstraint new
		  objectClass: Color;
		  generator: (UmeOptionsGenerator new from: Color indexedColors)
]

{ #category : 'running' }
UmeBlocBenchsTest >> blContainerConstraint [

	^ UmeObjectConstraint new
		  generator: (UmeGenerator onceInstance: [ :container :props |
					   container layout:
							   (BlGridLayout new columnCount: (1 to: 200) atRandom).
					   container layout cellSpacing: (1 to: 5) atRandom.
					   container constraintsDo: [ :c |
							   c vertical matchParent.
							   c horizontal matchParent ].
					   (100 to: 1000) atRandom timesRepeat: [
							   container addChild: (props at: 'child') gen ].
					   container beInSingleCompositionLayer.
					   container ] of: BlElement);
		  props: { ('child' -> self blChildConstraint) }
]

{ #category : 'running' }
UmeBlocBenchsTest >> blElementConstraint [

	^ 	UmeObjectConstraint new
		                      generator:
			                      (UmeGenerator onceInstance: [ :element :props |
					                       element constraintsDo: [ :c |
							                       c vertical matchParent.
							                       c horizontal matchParent ].
					                       element addChild:
							                       (props at: 'container') gen.
					                       element addChild:
							                       (props at: 'transparent') gen.
					                       element ] of: BlElement);
		                      props: {
										('container' -> self blContainerConstraint) .
										('transparent' -> self blTransparentConstraint)
									}.
]

{ #category : 'running' }
UmeBlocBenchsTest >> blGeometryConstraint [

	^ UmeObjectConstraint new
		  generator: (UmeGenerator oneOf: { BlRectangleGeometry new . BlTriangleGeometry new ". BlCircleGeometry new" })
]

{ #category : 'running' }
UmeBlocBenchsTest >> blSpinnerConstraint [

	^ UmeObjectConstraint new
		  generator: (UmeGenerator onceInstance: [ :spinner :props |
					   spinner constraintsDo: [ :c |
							   c frame vertical alignCenter.
							   c frame horizontal alignCenter ].
					   spinner height: (10 to: 100) atRandom.
					   spinner width: (10 to: 100) atRandom.
						spinner geometry: (props at: 'geometry') gen.
					   spinner background: (props at: 'color') gen.
					   spinner addAnimation: ((BlTransformAnimation rotate: 180)
								    duration: (0.5 to: 5.0) atRandom seconds;
								    easing: BlLinearInterpolator new;
								    target: spinner;
								    beInfinite;
								    yourself).
					   spinner ] of: BlElement);
		  props: { 
			('color' -> self blColorConstraint).
			'geometry' -> self blGeometryConstraint }
]

{ #category : 'running' }
UmeBlocBenchsTest >> blTransparentConstraint [

	^ UmeObjectConstraint new
		  generator: (UmeGenerator onceInstance: [ :transparent :props |
					   transparent layout: BlFrameLayout new.
					   transparent background: (props at: 'color') gen.
					   transparent constraintsDo: [ :c |
							   c vertical matchParent.
							   c horizontal matchParent ].
					   transparent addChild: (props at: 'spinner') gen.
					   transparent beInSingleCompositionLayer.
					   transparent ] of: BlElement);
		  props: { ('spinner' -> self blSpinnerConstraint) . ('color' -> self blColorConstraint) }
]

{ #category : 'running' }
UmeBlocBenchsTest >> setUp [

	super setUp.
	self timeLimit: 5 minutes.
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
UmeBlocBenchsTest >> testGivingABlocBenchSchemaThenGenerateCasesToAnalyseCoverageAndPerformance [

	| result |

	resutl := (UmeRunner test: BlBCase >> #run from: schema times: 2) run.

	self assertSuccess: result.
	self assert: (result tests size) equals: 10.
]
