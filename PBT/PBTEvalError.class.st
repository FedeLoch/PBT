Class {
	#name : 'PBTEvalError',
	#superclass : 'Object',
	#instVars : [
		'stack'
	],
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'accessing' }
PBTEvalError >> coverageResult [

	^ nil 
]

{ #category : 'accessing' }
PBTEvalError >> stack: aStack [

	stack := aStack 
]
