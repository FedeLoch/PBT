Class {
	#name : 'PBTMinimizerTest',
	#superclass : 'TestCase',
	#category : 'PBT-Corpus Minimization',
	#package : 'PBT',
	#tag : 'Corpus Minimization'
}

{ #category : 'tests' }
PBTMinimizerTest >> testUnweightedMinimization [

	| f1 f2 f3 minimizer corpus shrunk |
	
	"F1 covers Key1 (Record)"
	f1 := PBTFeedback from: 'case1' improvement: 1 values: { 'key1' -> 100 } asDictionary.
	"F2 covers Key2 (Record)"
	f2 := PBTFeedback from: 'case2' improvement: 1 values: { 'key2' -> 200 } asDictionary.
	"F3 covers both Key1 and Key2 (Records)"
	f3 := PBTFeedback from: 'case3' improvement: 1 values: { 'key1' -> 100 . 'key2' -> 200 } asDictionary.
	
	corpus := { f1 . f2 . f3 }.
	minimizer := PBTUnweightedMinimizer new.
	
	shrunk := minimizer minimize: corpus.
	
	self assert: shrunk size equals: 1.
	self assert: shrunk first equals: f3
]

{ #category : 'tests' }
PBTMinimizerTest >> testWeightedMinimizationByCost [

	| f1 f2 minimizer corpus shrunk |
	
	"F1 covers Key1, cost 100 (e.g. slow)"
	f1 := PBTFeedback from: 'slow' improvement: 1 values: { 'key1' -> 100 } asDictionary.
	"F2 covers Key1, cost 10 (e.g. fast)"
	f2 := PBTFeedback from: 'fast' improvement: 1 values: { 'key1' -> 100 } asDictionary.
	
	corpus := { f1 . f2 }.
	minimizer := PBTWeightedMinimizer new.
	"Cost is the length of the 'case' string in this mock test"
	minimizer costBlock: [ :fb | fb case size ].
	
	shrunk := minimizer minimize: corpus.
	
	self assert: shrunk size equals: 1.
	self assert: shrunk first equals: f2. "Fast Case"
]

{ #category : 'tests' }
PBTMinimizerTest >> testWeightedMinimizationTieBreak [

	| f1 f2 minimizer corpus shrunk |
	
	"F1 and F2 have same coverage and same cost"
	f1 := PBTFeedback from: 'case' improvement: 1 values: { 'key1' -> 100 } asDictionary.
	f2 := PBTFeedback from: 'case' improvement: 1 values: { 'key1' -> 100 } asDictionary.
	
	corpus := { f1 . f2 }.
	minimizer := PBTWeightedMinimizer new.
	
	shrunk := minimizer minimize: corpus.
	
	"One should be picked"
	self assert: shrunk size equals: 1.
]
