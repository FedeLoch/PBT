Class {
	#name : 'PBTRandomREExperiment',
	#superclass : 'PBTBugDetectionExperiment',
	#instVars : [
		'time'
	],
	#category : 'PBT-Experimentation',
	#package : 'PBT',
	#tag : 'Experimentation'
}

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> classesToMutate [

	^ { RxMatcher ". RxParser" }
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> gramatronConfig [

	^ self
		  executionConfig: (self schemaWith: self gramatronRegexConstraint)
		  called: 'Gramatron'
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> gramatronRegexConstraint [

	^ PBTObjectConstraint new generator: (PBTGrammarGramatronGenerator from: GnfRegexGrammar new ofDepth: 10)
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> hillClimbingAndOpRegexConstraint [

	| randomGenerator mutationGeneration regexGenerator |
	randomGenerator := PBTObjectConstraint new
		                   objectClass: String;
		                   generator: (PBTGrammarGenerator new
				                    grammar: GncRegexGrammar new;
				                    maxHeight: 100;
				                    maxSize: 100).

	mutationGeneration := PBTDyncamicSelectionGenerator new generators:
		                      {
			                      (PBTGenerator always:
				                       (PBTMutator mutate: [ :regex |
					                        RxMatcher
						                        mutateCharacter: regex
						                        using: randomGenerator gen ])). "Basic one mutating a random character"
			                      (PBTGenerator always:
				                       (PBTMutator mutate: [ :regex |
					                        RxMatcher
						                        mutateCharacter: regex
						                        using: randomGenerator gen
						                        times: (2 to: 10) atRandom ])).
			                      (PBTGenerator always:
				                       (PBTMutator mutate: [ :regex |
					                        RxMatcher invertOptionalByStarts: regex ])).
			                      (PBTGenerator always:
				                       (PBTMutator mutate: [ :regex |
					                        RxMatcher invertPlusByStarts: regex ])).
			                      (PBTGenerator always:
				                       (PBTMutator mutate: [ :regex |
					                        RxMatcher invertStarsByPlus: regex ])).
			                      (PBTGenerator always:
				                       (PBTMutator mutate: [ :regex |
					                        RxMatcher shiftUntilValid: regex ])) }.
	"Array of Mutators constant generators"

	regexGenerator := PBTGenerator
		                  base: [
			                  | re |
			                  re := randomGenerator gen.
			                  [ re size = 40 ] whileFalse: [
				                  re := randomGenerator gen ].
			                  re ]
		                  mutating: [ :regexString :constraint :feedback |
			                  (mutationGeneration gen: constraint by: feedback)
				                  mutate: regexString ].

	^ PBTObjectConstraint new generator: regexGenerator
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> hillClimbingAndOptConfig [

	^ self
		  executionConfig:
		  (self schemaWith: self hillClimbingAndOpRegexConstraint)
		  called: 'HillClimbing with optional regex constraint'
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> hillClimbingConfig [

	^ self
		  executionConfig:
		  (self schemaWith: self hillClimbingRegexConstraint)
		  called: 'HillClimbing'
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> hillClimbingRegexConstraint [

	| randomGenerator regexGenerator |
	randomGenerator := PBTObjectConstraint new
		                   objectClass: String;
		                   generator: (PBTGrammarGenerator new
				                    grammar: GncRegexGrammar new;
				                    maxHeight: 100;
				                    maxSize: 100).

	regexGenerator := PBTGenerator
		                  base: [
			                  | re |
			                  re := randomGenerator gen.
			                  [ re size = 40 ] whileFalse: [
				                  re := randomGenerator gen ].
			                  re ]
		                  mutating: [ :regexString :constraint :feedback |
			                  RxMatcher
				                  mutateCharacter: regexString
				                  using: randomGenerator gen ].

	^ PBTObjectConstraint new generator: regexGenerator
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> mctsConfig [

	^ self
		  executionConfig: (self schemaWith: self mctsRegexConstraint)
		  called: 'MCTS'
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> mctsRegexConstraint [

	^ PBTObjectConstraint new generator: (PBTGrammarMCTSGenerator from: GncRegexGrammar new)
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> pbtConfigurations [

	^ {
		  self mctsConfig.
		  self hillClimbingConfig.
		  self hillClimbingAndOptConfig.
		  self sdGenConfig.
		  self gramatronConfig.
	}
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> regexByProp: props and: feedback [

	| regex |
	regex := nil.

	[ regex ] whileNil: [
		[
		| maybe |
		maybe := (props at: 'grammar') genBy: feedback.
		maybe asRegex.
		regex := maybe ]
			on: Error
			do: [  ] ].

	^ regex
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> schemaWith: regexConstraint [

	| sharedProperties generator receiverConstraint argumentConstraints assert score |
	sharedProperties := InternalConstraintProperties from:
		                    { ('grammar' -> regexConstraint) } asDictionary.

	generator := PBTGenerator do: [ :props :feedback |
		             | regex |
		             regex := self regexByProp: props and: feedback.
		             props at: 'input' put: regex minimalStringMatching.
		             regex asRegex ].

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

	assert := [ :regex :input :result | (regex matches: input) = result ].
	score := [ :re :inputs :res |
	         | coreScore gnoccoScore anotherRegex base |
	         coreScore := res time asMilliSeconds.
	         anotherRegex := inputs first asRegex.
	
				base := Smalltalk highResClock.
				anotherRegex matches: inputs first.
				
	         gnoccoScore := Smalltalk highResClock - base.
	         (coreScore / (gnoccoScore max: 1)) asFloat ].

	^ PBTSchema new
		  receiverConstraint: receiverConstraint;
		  argumentConstraints: argumentConstraints;
		  score: score;
		  assert: assert
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> sdGenConfig [

	^ self
		  executionConfig: (self schemaWith: self sdGenRegexConstraint)
		  called: 'SdGen'
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> sdGenRegexConstraint [
	
	| grammarRegex |
	grammarRegex := GncRegexGrammar new.
	
	^ PBTObjectConstraint new generator: (PBTGrammarSdGenGenerator from: grammarRegex ofDepth: 10)
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> target [

	^ RxMatcher >> #matches:
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> time [

	^ time
]

{ #category : 'as yet unclassified' }
PBTRandomREExperiment >> time: aTime [

	time := aTime 
]
