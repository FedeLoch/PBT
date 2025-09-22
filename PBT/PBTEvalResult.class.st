Class {
	#name : 'PBTEvalResult',
	#superclass : 'Object',
	#instVars : [
		'callResult',
		'coverageResult',
		'profilingResult'
	],
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'accessing' }
PBTEvalResult >> callResult [

	^ callResult 
]

{ #category : 'accessing' }
PBTEvalResult >> callResult: aCallResult [
	
	callResult := aCallResult
	
]

{ #category : 'accessing' }
PBTEvalResult >> coverageResult [

	^ coverageResult 
]

{ #category : 'accessing' }
PBTEvalResult >> coverageResult: aCoverageResult [
	
	coverageResult := aCoverageResult
	
]

{ #category : 'accessing' }
PBTEvalResult >> profilingResult [

	^ profilingResult 
]

{ #category : 'accessing' }
PBTEvalResult >> profilingResult: result [

	profilingResult := result 
]
