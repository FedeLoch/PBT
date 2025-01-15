Class {
	#name : 'PBTEvalResult',
	#superclass : 'Object',
	#instVars : [
		'callResult',
		'coverageResult'
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
PBTEvalResult >> coverageResult: aCoverageResult [
	
	coverageResult := aCoverageResult
	
]
