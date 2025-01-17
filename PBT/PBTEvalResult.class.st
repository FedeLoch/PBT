Class {
	#name : 'PBTEvalResult',
	#superclass : 'Object',
	#instVars : [
		'callResult',
		'coverageResult',
		'allocatedMemory'
	],
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'accessing' }
PBTEvalResult >> allocatedMemory [

	^ allocatedMemory 
]

{ #category : 'accessing' }
PBTEvalResult >> allocatedMemory: memory [

	allocatedMemory := memory 
]

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
PBTEvalResult >> initialize [ 

	super initialize.
	allocatedMemory := 0
]
