Class {
	#name : 'PBTDateParserTest',
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
PBTDateParserTest >> dateConstraint [

	^ PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: PzDateMDYYYYGrammar new) 
	
	
]

{ #category : 'running' }
PBTDateParserTest >> datePattern [

	^ 'm-d-yyyy'
]

{ #category : 'running' }
PBTDateParserTest >> setUp [

	super setUp.

	receiverConstraint := PBTObjectConstraint new
		                      generator: (PBTGenerator
				                       onceInstance: [ :parser :props |
					                       DateParser
						                       readingFrom:
							                       (props at: 'date') gen readStream
						                       pattern: self datePattern ]
				                       of: DateParser);
		                      props: { ('date' -> self dateConstraint) }.

	assert := [ :coll :args :result | result class = Date ].
	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          assert: assert
]

{ #category : 'tests' }
PBTDateParserTest >> testGivingADateParseSchemaThenGenerateTestsForRandomInputs [

	| pbtResult |
	
	self timeLimit: 30 minutes.
	pbtResult := PBTRunner test: DateParser >> #parse from: schema times: 1000.

	self assert: (pbtResult tests size) equals: 1000.
]

{ #category : 'tests' }
PBTDateParserTest >> testGivingADateParseSchemaWithScoreThenGenerateTestsForRandomInputs [

	| pbtResult |
	
	self timeLimit: 30 minutes.
	
	schema score: [ :testCase | testCase allocatedMemory ].
	
	pbtResult := PBTRunner test: DateParser >> #parse from: schema times: 100.

	self assert: (pbtResult tests size) equals: 100.
]
