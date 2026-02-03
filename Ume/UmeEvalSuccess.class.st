Class {
	#name : 'UmeEvalSuccess',
	#superclass : 'UmeEvalResult',
	#category : 'Ume-Evaluation',
	#package : 'Ume',
	#tag : 'Evaluation'
}

{ #category : 'ston-core' }
UmeEvalSuccess class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( )
]
