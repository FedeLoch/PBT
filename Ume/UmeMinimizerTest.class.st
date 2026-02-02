Class {
	#name : 'UmeMinimizerTest',
	#superclass : 'TestCase',
	#category : 'Ume-Corpus Minimization',
	#package : 'Ume',
	#tag : 'Corpus Minimization'
}

{ #category : 'tests' }
UmeMinimizerTest >> testUnweightedMinimization [

	| f1 f2 f3 minimizer corpus shrunk |
	
	"F1 covers Key1 (Record)"
	f1 := UmeFeedback from: 'case1' improvement: 1 values: { 'key1' -> 100 } asDictionary.
	"F2 covers Key2 (Record)"
	f2 := UmeFeedback from: 'case2' improvement: 1 values: { 'key2' -> 200 } asDictionary.
	"F3 covers both Key1 and Key2 (Records)"
	f3 := UmeFeedback from: 'case3' improvement: 1 values: { 'key1' -> 100 . 'key2' -> 200 } asDictionary.
	
	corpus := { f1 . f2 . f3 }.
	minimizer := UmeUnweightedMinimizer new.
	
	shrunk := minimizer minimize: corpus.
	
	self assert: shrunk size equals: 1.
	self assert: shrunk first equals: f3
]

{ #category : 'tests' }
UmeMinimizerTest >> testWeightedMinimizationByCost [

	| f1 f2 minimizer corpus shrunk |
	
	"F1 covers Key1, cost 100 (e.g. slow)"
	f1 := UmeFeedback from: 'slow' improvement: 1 values: { 'key1' -> 100 } asDictionary.
	"F2 covers Key1, cost 10 (e.g. fast)"
	f2 := UmeFeedback from: 'fast' improvement: 1 values: { 'key1' -> 100 } asDictionary.
	
	corpus := { f1 . f2 }.
	minimizer := UmeWeightedMinimizer new.
	"Cost is the length of the 'case' string in this mock test"
	minimizer costBlock: [ :fb | fb case size ].
	
	shrunk := minimizer minimize: corpus.
	
	self assert: shrunk size equals: 1.
	self assert: shrunk first equals: f2. "Fast Case"
]

{ #category : 'tests' }
UmeMinimizerTest >> testWeightedMinimizationTieBreak [

	| f1 f2 minimizer corpus shrunk |
	
	"F1 and F2 have same coverage and same cost"
	f1 := UmeFeedback from: 'case' improvement: 1 values: { 'key1' -> 100 } asDictionary.
	f2 := UmeFeedback from: 'case' improvement: 1 values: { 'key1' -> 100 } asDictionary.
	
	corpus := { f1 . f2 }.
	minimizer := UmeWeightedMinimizer new.
	
	shrunk := minimizer minimize: corpus.
	
	"One should be picked"
	self assert: shrunk size equals: 1.
]
