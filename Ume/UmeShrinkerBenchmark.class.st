Class {
	#name : 'UmeShrinkerBenchmark',
	#superclass : 'Object',
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'configuration' }
UmeShrinkerBenchmark class >> shrinkerClasses [
	
	^ { 
		UmeShrinker.
		UmeDeltaDebuggingShrinker.
		UmeBinarySearchShrinker.
		UmeGreedyShrinker.
		UmeHierarchicalShrinker.
		UmeHybridShrinker
	}
]

{ #category : 'benchmarking' }
UmeShrinkerBenchmark class >> benchmark: input grammar: grammar evaluator: evaluator feedbackEvaluator: feedbackEvaluator programBlock: programBlock [

	| results |
	results := OrderedCollection new.
	
	self shrinkerClasses do: [ :shrinkerClass |
		| result |
		result := self benchmarkShrinker: shrinkerClass
			input: input
			grammar: grammar
			evaluator: evaluator
			feedbackEvaluator: feedbackEvaluator
			programBlock: programBlock.
		results add: result ].
	
	^ results
]

{ #category : 'benchmarking' }
UmeShrinkerBenchmark class >> benchmarkShrinker: shrinkerClass input: input grammar: grammar evaluator: evaluator feedbackEvaluator: feedbackEvaluator programBlock: programBlock [

	| shrinker originalSize originalScore shrunkInput shrunkSize shrunkScore duration iterationsBefore |
	
	shrinker := shrinkerClass new
		grammar: grammar;
		evaluator: evaluator;
		feedbackEvaluator: feedbackEvaluator;
		programBlock: programBlock;
		classesToProfile: evaluator classesToProfile;
		threshold: 0.95;
		maxIterations: 1000;
		yourself.
	
	originalSize := input size.
	originalScore := shrinker evalInput: input.
	
	iterationsBefore := shrinker memo size.
	
	duration := [ shrunkInput := shrinker shrink: input ] duration.
	
	shrunkSize := shrunkInput size.
	shrunkScore := shrinker evalInput: shrunkInput.
	
	^ UmeShrinkerBenchmarkResult new
		shrinkerClass: shrinkerClass;
		originalInput: input;
		originalSize: originalSize;
		originalScore: originalScore;
		shrunkInput: shrunkInput;
		shrunkSize: shrunkSize;
		shrunkScore: shrunkScore;
		duration: duration;
		reductionPercentage: ((originalSize - shrunkSize) / originalSize * 100) asFloat round: 2;
		iterationsUsed: (shrinker memo size - iterationsBefore);
		yourself
]

{ #category : 'benchmarking' }
UmeShrinkerBenchmark class >> printResults: results [
	
	| stream |
	stream := String new writeStream.
	
	stream
		nextPutAll: '=== SHRINKER BENCHMARK RESULTS ===';
		cr;
		cr.
	
	results do: [ :result |
		stream
			nextPutAll: result shrinkerClass name;
			cr;
			nextPutAll: '  Original:  ', result originalInput asString, ' (', result originalSize asString, ' chars, score: ', result originalScore asString, ')';
			cr;
			nextPutAll: '  Shrunk:    ', result shrunkInput asString, ' (', result shrunkSize asString, ' chars, score: ', result shrunkScore asString, ')';
			cr;
			nextPutAll: '  Reduction: ', result reductionPercentage asString, '%';
			cr;
			nextPutAll: '  Duration:  ', result duration asString;
			cr;
			nextPutAll: '  Iterations: ', result iterationsUsed asString;
			cr;
			cr ].
	
	^ stream contents
]

{ #category : 'benchmarking' }
UmeShrinkerBenchmark class >> runComparisonOn: testCases grammar: grammar evaluator: evaluator feedbackEvaluator: feedbackEvaluator programBlock: programBlock [

	| allResults summary |
	allResults := OrderedCollection new.
	
	testCases do: [ :input |
		| results |
		results := self benchmark: input grammar: grammar evaluator: evaluator feedbackEvaluator: feedbackEvaluator programBlock: programBlock.
		allResults add: { input. results } ].
	
	summary := self generateSummary: allResults.
	
	^ UmeShrinkerBenchmarkComparison new
		results: allResults;
		summary: summary;
		yourself
]

{ #category : 'benchmarking' }
UmeShrinkerBenchmark class >> generateSummary: allResults [
	
	| summary byShrinker |
	byShrinker := Dictionary new.
	
	self shrinkerClasses do: [ :shrinkerClass |
		| classResults |
		classResults := allResults select: [ :r | (r second detect: [ :res | res shrinkerClass = shrinkerClass ]) notNil ].
		byShrinker at: shrinkerClass put: classResults ].
	
	summary := Dictionary new.
	
	byShrinker keysAndValuesDo: [ :shrinkerClass :results |
		| avgReduction avgDuration avgIterations |
		results ifNotEmpty: [
			avgReduction := (results collect: [ :r | (r second detect: [ :res | res shrinkerClass = shrinkerClass ]) reductionPercentage ]) average.
			avgDuration := (results collect: [ :r | (r second detect: [ :res | res shrinkerClass = shrinkerClass ]) duration asMilliSeconds ]) average.
			avgIterations := (results collect: [ :r | (r second detect: [ :res | res shrinkerClass = shrinkerClass ]) iterationsUsed ]) average.
			
			summary at: shrinkerClass put: {
				#avgReduction -> avgReduction.
				#avgDuration -> avgDuration.
				#avgIterations -> avgIterations
			} asDictionary ] ].
	
	^ summary
]
