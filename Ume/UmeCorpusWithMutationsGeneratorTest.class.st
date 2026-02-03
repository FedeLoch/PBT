Class {
	#name : 'UmeCorpusWithMutationsGeneratorTest',
	#superclass : 'UmeGeneratorTest',
	#instVars : [
		'mutators',
		'heuristic',
		'generator',
		'subGenerator'
	],
	#category : 'Ume-Generators',
	#package : 'Ume',
	#tag : 'Generators'
}

{ #category : 'running' }
UmeCorpusWithMutationsGeneratorTest >> setUp [

	super setUp.
	subGenerator := UmeGrammarMCTSGenerator from: JSONGrammar new.
	heuristic := UmePickLastSelectorHeuristic new.
	mutators := {
		UmeMutator mutate: [ :jsonString  | '[', jsonString, ',', (subGenerator gen: nil), ']' ]
	}.
	
	generator := UmeCorpusGenerator new
		generator: subGenerator;
		mutators: mutators;
		heuristic: heuristic.
]

{ #category : 'tests' }
UmeCorpusWithMutationsGeneratorTest >> testGenerateTheAsecondInputWithNegativeFeedback [

	| first |
	first := generator gen: nil.
	
	generator feed: (UmeFeedback from: first value: false).
	
	self assert: (generator gen: nil) size equals: 2
]

{ #category : 'tests' }
UmeCorpusWithMutationsGeneratorTest >> testGenerateTheAsecondInputWithPositiveFeedback [

	| first |
	first := generator gen: nil.
	
	generator feed: (UmeFeedback from: first value: true).
	
	self assert: (generator gen: nil) equals: 'gjse'
]

{ #category : 'tests' }
UmeCorpusWithMutationsGeneratorTest >> testGenerateTheAsecondInputWithPositiveFeedbackFiveTimes [

	5 timesRepeat: [ | case |
		case := generator gen: nil.
		generator feed: (UmeFeedback from: case value: true).
	].
	
	self assert: (generator gen: nil) equals: 'godhpkhsp'
]

{ #category : 'tests' }
UmeCorpusWithMutationsGeneratorTest >> testGenerateTheAsecondInputWithPositiveFeedbackTwentyTimes [

	20 timesRepeat: [ | case |
		case := generator gen: nil.
		generator feed: (UmeFeedback from: case value: true).
	].
	
	self assert: (generator gen: nil) equals: 'godhpkhsp'
]

{ #category : 'tests' }
UmeCorpusWithMutationsGeneratorTest >> testGenerateTheFirstInput [
	
	self assert: (generator gen: nil) size equals: 2
]
