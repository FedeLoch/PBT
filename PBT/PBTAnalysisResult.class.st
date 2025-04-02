Class {
	#name : 'PBTAnalysisResult',
	#superclass : 'Object',
	#instVars : [
		'sensitivity',
		'comparisons'
	],
	#category : 'PBT-BugDetection',
	#package : 'PBT',
	#tag : 'BugDetection'
}

{ #category : 'adding' }
PBTAnalysisResult >> add: result for: baseResult called: label forMutant: mutantName [
	| baseMedian currentMedia |
	
	currentMedia := result bloxplotByTime median.
	baseMedian := baseResult bloxplotByTime median.
	
	comparisons at: mutantName ifAbsentPut: Dictionary new. 
	comparisons at: mutantName at: label put: currentMedia >= (baseMedian * (1 + sensitivity )).
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
