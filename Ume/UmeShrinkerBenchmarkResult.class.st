Class {
	#name : 'UmeShrinkerBenchmarkResult',
	#superclass : 'Object',
	#instVars : [
		'shrinkerClass',
		'originalInput',
		'originalSize',
		'originalScore',
		'shrunkInput',
		'shrunkSize',
		'shrunkScore',
		'duration',
		'reductionPercentage',
		'iterationsUsed'
	],
	#category : 'Ume-Shrinking',
	#package : 'Ume',
	#tag : 'Shrinking'
}

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> duration [
	^ duration
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> duration: anObject [
	duration := anObject
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> iterationsUsed [
	^ iterationsUsed
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> iterationsUsed: anObject [
	iterationsUsed := anObject
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> originalInput [
	^ originalInput
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> originalInput: anObject [
	originalInput := anObject
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> originalScore [
	^ originalScore
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> originalScore: anObject [
	originalScore := anObject
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> originalSize [
	^ originalSize
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> originalSize: anObject [
	originalSize := anObject
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> reductionPercentage [
	^ reductionPercentage
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> reductionPercentage: anObject [
	reductionPercentage := anObject
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> shrinkerClass [
	^ shrinkerClass
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> shrinkerClass: anObject [
	shrinkerClass := anObject
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> shrunkInput [
	^ shrunkInput
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> shrunkInput: anObject [
	shrunkInput := anObject
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> shrunkScore [
	^ shrunkScore
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> shrunkScore: anObject [
	shrunkScore := anObject
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> shrunkSize [
	^ shrunkSize
]

{ #category : 'accessing' }
UmeShrinkerBenchmarkResult >> shrunkSize: anObject [
	shrunkSize := anObject
]
