Class {
	#name : 'PBTEvalSuccess',
	#superclass : 'PBTEvalResult',
	#category : 'PBT-Evaluation',
	#package : 'PBT',
	#tag : 'Evaluation'
}

{ #category : 'ston-core' }
PBTEvalSuccess class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithoutAll: #( )
]
