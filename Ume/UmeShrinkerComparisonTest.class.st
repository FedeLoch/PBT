Class {
	#name : 'UmeShrinkerComparisonTest',
	#superclass : 'UmeFrameworkTest',
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'running' }
UmeShrinkerComparisonTest >> testDeltaDebuggingVsOriginal [
	"Compare Delta Debugging shrinker with original"
	
	| input grammar shrinkers results |
	
	input := self generateComplexRegexInput.
	grammar := GncRegexGrammar new.
	
	shrinkers := {
		UmeShrinker -> #original.
		UmeDeltaDebuggingShrinker -> #deltaDebugging
	}.
	
	results := shrinkers collect: [ :shrinkerClass :name |
		| shrinker originalScore shrunkInput shrunkScore duration |
		
		shrinker := shrinkerClass new
			grammar: grammar;
			evaluator: evaluator;
			feedbackEvaluator: feedbackEvaluator;
			programBlock: [ :regex | RxMatcher forString: regex ];
			classesToProfile: { RxMatcher };
			threshold: 0.95;
			maxIterations: 100;
			yourself.
		
		originalScore := shrinker evalInput: input.
		duration := [ shrunkInput := shrinker shrink: input ] duration.
		shrunkScore := shrinker evalInput: shrunkInput.
		
		name -> { 
			#original -> input. #shrunk -> shrunkInput.
			#originalScore -> originalScore. #shrunkScore -> shrunkScore.
			#duration -> duration.
			#reduction -> ((input size - shrunkInput size) / input size * 100)
		} asDictionary
	] asDictionary.
	
	self assert: (results at: #original) notNil.
	self assert: (results at: #deltaDebugging) notNil.
]

{ #category : 'running' }
UmeShrinkerComparisonTest >> testGreedyVsHybrid [
	"Compare Greedy vs Hybrid shrinkers"
	
	| input grammar |
	
	input := self generateComplexRegexInput.
	grammar := GncRegexGrammar new.
	
	Transcript show: 'Greedy: '; show: (self benchmarkShrinker: UmeGreedyShrinker on: input grammar: grammar); cr.
	Transcript show: 'Hybrid: '; show: (self benchmarkShrinker: UmeHybridShrinker on: input grammar: grammar); cr.
]

{ #category : 'running' }
UmeShrinkerComparisonTest >> testAllShrinkers [
	"Compare all shrinker implementations"
	
	| testCases grammar comparison |
	
	testCases := {
		self generateComplexRegexInput.
		self generateNestedJSONInput.
		self generateLongStringInput
	}.
	
	grammar := GncRegexGrammar new.
	
	comparison := UmeShrinkerBenchmark runComparisonOn: testCases
		grammar: grammar
		evaluator: evaluator
		feedbackEvaluator: feedbackEvaluator
		programBlock: [ :input | RxMatcher forString: input ].
	
	Transcript show: comparison printDetailedReport.
	
	self assert: comparison summary notEmpty
]

{ #category : 'utilities' }
UmeShrinkerComparisonTest >> benchmarkShrinker: shrinkerClass on: input grammar: grammar [

	| shrinker originalSize shrunkSize duration |
	
	shrinker := shrinkerClass new
		grammar: grammar;
		evaluator: evaluator;
		feedbackEvaluator: feedbackEvaluator;
		programBlock: [ :in | RxMatcher forString: in ];
		classesToProfile: { RxMatcher };
		threshold: 0.95;
		maxIterations: 100;
		yourself.
	
	originalSize := input size.
	duration := [ shrunkSize := (shrinker shrink: input) size ] duration.
	
	^ String streamContents: [ :s |
		s
			<< 'Size: ' << originalSize asString << ' -> ' << shrunkSize asString;
			<< ' | Reduction: ' << ((originalSize - shrunkSize / originalSize * 100) asFloat round: 1) asString << '%';
			<< ' | Time: ' << (duration asMilliSeconds round: 1) asString << 'ms'
	]
]

{ #category : 'utilities' }
UmeShrinkerComparisonTest >> generateComplexRegexInput [
	"Generate a complex regex that triggers performance issues"
	
	^ String streamContents: [ :s |
		s << '^(a+)+b$'.
		50 timesRepeat: [ s << 'a' ].
		s << 'c' "This makes it fail"
	]
]

{ #category : 'utilities' }
UmeShrinkerComparisonTest >> generateNestedJSONInput [
	"Generate nested JSON that may cause performance issues"
	
	| depth |
	depth := 20.
	
	^ String streamContents: [ :s |
		depth timesRepeat: [ s << '{"key":' ].
		s << '"value"'.
		depth timesRepeat: [ s << '}' ].
	]
]

{ #category : 'utilities' }
UmeShrinkerComparisonTest >> generateLongStringInput [
	"Generate a long input string"
	
	^ String new: 500 streamContents: [ :s |
		500 timesRepeat: [ s << 'abcdefghijklmnopqrstuvwxyz' atRandom ]
	]
]

{ #category : 'running' }
UmeShrinkerComparisonTest >> setUp [
	super setUp.
	evaluator := UmeEvaluator new.
	feedbackEvaluator := UmeFeedbackEvaluator new.
]
