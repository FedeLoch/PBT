Class {
	#name : 'PBTAnalysisResult',
	#superclass : 'Object',
	#instVars : [
		'sensitivity'
	],
	#category : 'PBT-BugDetection',
	#package : 'PBT',
	#tag : 'BugDetection'
}

{ #category : 'adding' }
PBTAnalysisResult >> add: cases for: baseCases to: label [

	"TODO"
]

{ #category : 'adding' }
PBTAnalysisResult >> initialize [ 

	super initialize.
	
]

{ #category : 'as yet unclassified' }
PBTAnalysisResult >> sensitivity: aSensitivity [

	sensitivity := aSensitivity.
]
