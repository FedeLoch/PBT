Class {
	#name : 'UmeEvalError',
	#superclass : 'UmeEvalResult',
	#instVars : [
		'stack',
		'message'
	],
	#category : 'Ume-Evaluation',
	#package : 'Ume',
	#tag : 'Evaluation'
}

{ #category : 'ston-core' }
UmeEvalError class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( stack )
]

{ #category : 'accessing' }
UmeEvalError >> message [

	^ message 
]

{ #category : 'accessing' }
UmeEvalError >> message: aMessage [

	message := aMessage 
]

{ #category : 'accessing' }
UmeEvalError >> stack: aStack [

	stack := aStack 
]
