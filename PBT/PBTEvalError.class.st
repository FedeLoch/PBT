Class {
	#name : 'PBTEvalError',
	#superclass : 'PBTEvalResult',
	#instVars : [
		'stack',
		'message'
	],
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'accessing' }
PBTEvalError >> allocatedMemory: memory [

	allocatedMemory := memory ifNil: [ allocatedMemory ] ifNotNil: [ memory ]
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

{ #category : 'accessing' }
PBTEvalError >> time: aTime [

	time := aTime ifNil: [ time ] ifNotNil: [ aTime ]
]
