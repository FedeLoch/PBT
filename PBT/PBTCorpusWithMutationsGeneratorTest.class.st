Class {
	#name : 'PBTCorpusWithMutationsGeneratorTest',
	#superclass : 'PBTGeneratorTest',
	#instVars : [
		'mutators',
		'heuristic',
		'generator',
		'subGenerator'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'running' }
PBTCorpusWithMutationsGeneratorTest >> setUp [

	super setUp.
	subGenerator := PBTGrammarMCTSGenerator from: JSONGrammar new.
	heuristic := PBTPickLastSelectorHeuristic new.
	mutators := {
		PBTMutator mutate: [ :jsonString  | '[', jsonString, ',', (subGenerator gen: nil), ']' ]
	}.
	
	generator := PBTCorpusWithMutationsGenerator new
		generator: subGenerator;
		mutators: mutators;
		heuristic: heuristic.
]

{ #category : 'tests' }
PBTCorpusWithMutationsGeneratorTest >> testGenerateTheAsecondInputWithNegativeFeedback [

	| first |
	first := generator gen: nil.
	
	generator feed: (PBTFeedback from: first value: false).
	
	self assert: (generator gen: nil) size equals: 2
]

{ #category : 'tests' }
PBTCorpusWithMutationsGeneratorTest >> testGenerateTheAsecondInputWithPositiveFeedback [

	| first |
	first := generator gen: nil.
	
	generator feed: (PBTFeedback from: first value: true).
	
	self assert: (generator gen: nil) equals: 'gjse'
]

{ #category : 'tests' }
PBTCorpusWithMutationsGeneratorTest >> testGenerateTheAsecondInputWithPositiveFeedbackFiveTimes [

	5 timesRepeat: [ | case |
		case := generator gen: nil.
		generator feed: (PBTFeedback from: case value: true).
	].
	
	self assert: (generator gen: nil) equals: 'godhpkhsp'
]

{ #category : 'tests' }
PBTCorpusWithMutationsGeneratorTest >> testGenerateTheAsecondInputWithPositiveFeedbackTwentyTimes [

	20 timesRepeat: [ | case |
		case := generator gen: nil.
		generator feed: (PBTFeedback from: case value: true).
	].
	
	self assert: (generator gen: nil) equals: 'godhpkhsp'
]

{ #category : 'tests' }
PBTCorpusWithMutationsGeneratorTest >> testGenerateTheFirstInput [
	
	self assert: (generator gen: nil) size equals: 2
]
