Class {
	#name : 'UmeEvalResult',
	#superclass : 'Object',
	#instVars : [
		'callResult',
		'coverageResult',
		'profilingResult'
	],
	#category : 'Ume-Evaluation',
	#package : 'Ume',
	#tag : 'Evaluation'
}

{ #category : 'accessing' }
UmeEvalResult >> allocatedMemory [

	profilingResult ifNil: [ ^ -1 ].
	
	^ profilingResult memory
	
]

{ #category : 'accessing' }
UmeEvalResult >> callResult [

	^ callResult 
]

{ #category : 'accessing' }
UmeEvalResult >> callResult: aCallResult [
	
	callResult := aCallResult
	
]

{ #category : 'accessing' }
UmeEvalResult >> coverageResult [

	^ coverageResult 
]

{ #category : 'accessing' }
UmeEvalResult >> coverageResult: aCoverageResult [
	
	coverageResult := aCoverageResult
	
]

{ #category : 'accessing' }
UmeEvalResult >> profilingResult [

	^ profilingResult 
]

{ #category : 'accessing' }
UmeEvalResult >> profilingResult: result [

	profilingResult := result 
]

{ #category : 'accessing' }
UmeEvalResult >> time [

	profilingResult ifNil: [ ^ Duration microSeconds: -1 ].
	
	^ Duration microSeconds: profilingResult executionTime
	
]
