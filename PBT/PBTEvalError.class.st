Class {
	#name : 'PBTEvalError',
	#superclass : 'Object',
	#instVars : [
		'stack',
		'coverageResult',
		'message',
		'allocatedMemory',
		'time'
	],
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'accessing' }
PBTEvalError >> allocatedMemory [

	^ allocatedMemory
]

{ #category : 'accessing' }
PBTEvalError >> allocatedMemory: memory [

	allocatedMemory := memory
]

{ #category : 'accessing' }
PBTEvalError >> coverageResult [

	^ coverageResult 
]

{ #category : 'accessing' }
PBTEvalError >> coverageResult: aCoverageResult [
	
	coverageResult := aCoverageResult
	
]

{ #category : 'initialization' }
PBTEvalError >> initialize [ 

	super initialize.
	allocatedMemory := 0.
	time := 0
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

{ #category : 'initialization' }
PBTEvalError >> time [

	^ time
]

{ #category : 'initialization' }
PBTEvalError >> time: aTime [

	time := aTime 
]
