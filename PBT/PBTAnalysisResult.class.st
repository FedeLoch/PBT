Class {
	#name : 'PBTAnalysisResult',
	#superclass : 'Object',
	#instVars : [
		'sensitivity',
		'comparisons',
		'baseline'
	],
	#category : 'PBT-BugDetection',
	#package : 'PBT',
	#tag : 'BugDetection'
}

{ #category : 'adding' }
PBTAnalysisResult >> add: result called: label forMutant: mutantName [
	| baseMedian currentMedia |
	
	currentMedia := result bloxplotByTime median.
	baseMedian := baseline bloxplotByTime median.
	
	comparisons at: mutantName ifAbsentPut: Dictionary new. 
	comparisons at: mutantName at: label put: {
		currentMedia >= (baseMedian * (1 + sensitivity )).
		result
	}.
]

{ #category : 'as yet unclassified' }
PBTAnalysisResult >> baseline: aBaseline [

	baseline := aBaseline.
]

{ #category : 'adding' }
PBTAnalysisResult >> initialize [ 

	super initialize.
	comparisons := Dictionary new.
	
]

{ #category : 'as yet unclassified' }
PBTAnalysisResult >> sensitivity: aSensitivity [

	sensitivity := aSensitivity.
]
