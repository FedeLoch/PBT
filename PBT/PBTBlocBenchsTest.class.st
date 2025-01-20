Class {
	#name : 'PBTBlocBenchsTest',
	#superclass : 'PBTFrameworkTest',
	#instVars : [
		'schema',
		'receiverConstraint',
		'assert'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTBlocBenchsTest >> blChildConstraint [

	^ PBTObjectConstraint new
		  objectClass: BlElement;
		  generator: (PBTGenerator onceInstance: [ :element :props |
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
					   element ]);
		  props: { ('color' -> self blColorConstraint) }
]

{ #category : 'running' }
PBTBlocBenchsTest >> blColorConstraint [

	^ PBTObjectConstraint new
		  objectClass: Color;
		  generator: (PBTOptionsGenerator new from: Color indexedColors)
]

{ #category : 'running' }
PBTBlocBenchsTest >> blContainerConstraint [

	^ PBTObjectConstraint new
		  objectClass: BlElement;
		  generator: (PBTGenerator onceInstance: [ :container :props |
					   container layout:
							   (BlGridLayout new columnCount: (1 to: 200) atRandom).
					   container layout cellSpacing: (1 to: 5) atRandom.
					   container constraintsDo: [ :c |
							   c vertical matchParent.
							   c horizontal matchParent ].
					   (100 to: 1000) atRandom timesRepeat: [
							   container addChild: (props at: 'child') gen ].
					   container beInSingleCompositionLayer.
					   container ]);
		  props: { ('child' -> self blChildConstraint) }
]

{ #category : 'running' }
PBTBlocBenchsTest >> blElementConstraint [

	^ 	PBTObjectConstraint new
		                      objectClass: BlElement;
		                      generator:
			                      (PBTGenerator onceInstance: [ :element :props |
					                       element constraintsDo: [ :c |
							                       c vertical matchParent.
							                       c horizontal matchParent ].
					                       element addChild:
							                       (props at: 'container') gen.
					                       element addChild:
							                       (props at: 'transparent') gen.
					                       element ]);
		                      props: {
										('container' -> self blContainerConstraint) .
										('transparent' -> self blTransparentConstraint)
									}.
]

{ #category : 'running' }
PBTBlocBenchsTest >> blGeometryConstraint [

	^ PBTObjectConstraint new
		  generator: (PBTGenerator oneOf: { BlRectangleGeometry new . BlTriangleGeometry new ". BlCircleGeometry new" })
]

{ #category : 'running' }
PBTBlocBenchsTest >> blSpinnerConstraint [

	^ PBTObjectConstraint new
		  objectClass: BlElement;
		  generator: (PBTGenerator onceInstance: [ :spinner :props |
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
					   spinner ]);
		  props: { 
			('color' -> self blColorConstraint).
			'geometry' -> self blGeometryConstraint }
]

{ #category : 'running' }
PBTBlocBenchsTest >> blTransparentConstraint [

	^ PBTObjectConstraint new
		  objectClass: BlElement;
		  generator: (PBTGenerator onceInstance: [ :transparent :props |
					   transparent layout: BlFrameLayout new.
					   transparent background: (props at: 'color') gen.
					   transparent constraintsDo: [ :c |
							   c vertical matchParent.
							   c horizontal matchParent ].
					   transparent addChild: (props at: 'spinner') gen.
					   transparent beInSingleCompositionLayer.
					   transparent ]);
		  props: { ('spinner' -> self blSpinnerConstraint) . ('color' -> self blColorConstraint) }
]

{ #category : 'running' }
PBTBlocBenchsTest >> setUp [

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
PBTBlocBenchsTest >> testGivingABlocBenchSchemaThenGenerateCasesToAnalyseCoverageAndPerformance [

	| pbtResult |

	self timeLimit: 5 minutes.
	pbtResult := PBTRunner test: BlBCase >> #run from: schema times: 10.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 10.
]
