Class {
	#name : 'PBTEvalError',
	#superclass : 'Object',
	#instVars : [
		'stack',
		'coverageResult'
	],
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'accessing' }
PBTEvalError >> coverageResult [

	^ coverageResult 
]

{ #category : 'accessing' }
PBTEvalError >> coverageResult: aCoverageResult [
	
	coverageResult := aCoverageResult
	
]

{ #category : 'accessing' }
PBTEvalError >> stack: aStack [

	stack := aStack 
]
