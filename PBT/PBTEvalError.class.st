Class {
	#name : 'PBTEvalError',
	#superclass : 'Object',
	#instVars : [
		'stack',
		'coverageResult',
		'message'
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
PBTEvalError >> message [

	^ message 
]

{ #category : 'accessing' }
PBTEvalError >> message: aMessage [

	message := aMessage 
]

{ #category : 'accessing' }
PBTEvalError >> stack: aStack [

	stack := aStack 
]
