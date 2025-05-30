Class {
	#name : 'PBTRegexBugExperimentTest',
	#superclass : 'PBTFrameworkTest',
	#instVars : [
		'schema',
		'receiverConstraint',
		'argumentConstraints',
		'assert',
		'score'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'running' }
PBTRegexBugExperimentTest >> regexByProp: props and: feedback [
	""

	| regex |
	regex := nil.

	[ regex ] whileNil: [
		[
		| maybe |
		maybe := (props at: 'grammar') genBy: feedback.
		(PBTRegex fromString: maybe) compileRegex.
		regex := maybe ]
			on: Error
			do: [ :e | "1 halt." ] ].

	^ regex
]

{ #category : 'running' }
PBTRegexBugExperimentTest >> regexConstraint [

	^ PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: GncRegexGrammar new; maxHeight: 100; maxSize: 100)
]

{ #category : 'running' }
PBTRegexBugExperimentTest >> setUp [

	| generator sharedProperties |
	
	super setUp.
	self timeLimit: 5 hours.

	sharedProperties := InternalConstraintProperties from:
		                    { ('grammar' -> self regexConstraint) }
			                    asDictionary.

	generator := PBTGenerator do: [ :props :feedback |
		             | regex |
		             regex := self regexByProp: props and: feedback. "(props at: 'grammar') genBy: feedback."
		             props at: 'input' put: regex minimalStringMatching.
						 PBTRegex fromString: regex ].

	receiverConstraint := PBTObjectConstraint new
		                      objectClass: RxMatcher;
		                      generator: generator;
		                      props: sharedProperties.

	argumentConstraints := { (PBTObjectConstraint new
		                        objectClass: String;
		                        props: sharedProperties;
		                        generator:
			                        (PBTGenerator do: [ :props :feedback |
					                         props at: 'input' ])) }.

	assert := [ :regex :input :result | result ].
	
	score := [ :re :inputs :res | | coreScore gnoccoScore anotherRegex base | "Replicating the score experiment"
		coreScore := res time asMilliSeconds.
		anotherRegex := inputs first asRegex.
		
		base := Smalltalk highResClock.
		anotherRegex matches: inputs first.
		gnoccoScore := Smalltalk highResClock - base.
		(coreScore / (gnoccoScore max: 1)) asFloat "This allows us to avoid division by zero"
	].

	schema := PBTSchema new
		          receiverConstraint: receiverConstraint;
		          argumentConstraints: argumentConstraints;
		          score: score;
		          assert: assert
]

{ #category : 'tests' }
PBTRegexBugExperimentTest >> testGivingARegexFuzzerGeneratorThenWeForceThePerformanceBug [

	| pbtResult |
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.

	self assert: (pbtResult tests size) equals: 10000.

]

{ #category : 'tests' }
PBTRegexBugExperimentTest >> testGivingARegexFuzzerGeneratorThenWeForceThePerformanceBugByTime [

	| pbtResult |
	
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema for: 10 minutes.

	self assert: (pbtResult tests size) equals: 10000.
]
