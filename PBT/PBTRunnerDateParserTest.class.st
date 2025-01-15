Class {
	#name : 'PBTRunnerDateParserTest',
	#superclass : 'PBTRunnerTest',
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
PBTRunnerDateParserTest >> dateConstraint [

	^ PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: PzDateMDYYYYGrammar new) 
	
	
]

{ #category : 'running' }
PBTRunnerDateParserTest >> datePattern [

	^ 'm-d-yyyy'
]

{ #category : 'running' }
PBTRunnerDateParserTest >> setUp [

	super setUp.

	receiverConstraint := PBTObjectConstraint new
		                      objectClass: DateParser;
		                      generator:
			                      (PBTGenerator onceInstance: [ :parser :props |
					                       DateParser
						                       readingFrom:
							                       (props at: 'date') gen readStream
						                       pattern: self datePattern ]);
		                      props: { ('date' -> self dateConstraint) }.

	assert := [ :coll :args :result | result class = Date ].
	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          assert: assert
]

{ #category : 'tests' }
PBTRunnerDateParserTest >> testGivingADateParseSchemaThenGenerateTestsForRandomInputs [

	| pbtResult |

	pbtResult := PBTRunner test: DateParser >> #parse from: schema times: 1000.

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 1000.
]
