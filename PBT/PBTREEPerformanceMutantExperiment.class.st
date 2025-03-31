Class {
	#name : 'PBTREEPerformanceMutantExperiment',
	#superclass : 'PBTRandomREExperiment',
	#instVars : [
		'sensitivity',
		'mutants'
	],
	#category : 'PBT-BugDetection',
	#package : 'PBT',
	#tag : 'BugDetection'
}

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> analyze [

	"Given a sensitivity level T,
		1 - We generate a base sample of N inputs ( MI ) per each PBT config c_i.
		2 - We generate a box plot for each result.
		3 - Per each Mutant m_i, we install it
			3.1 - Per each config c_j, we generate N inputs ( MM )
			3.2 - We compare each MM_k with respect to the boxplot and we select the outliers number for m_i
			3.3 - We save the amount of outliers who identified the effect of m_i"

	^ mutants inject: (PBTAnalysisResult new sensitivity: sensitivity) into: [ :result :mutant |
		mutant install.
		pbtConfigurations do: [ :config |
			result add: config run for: config result to: mutant title.
		].
		mutant uninstall.
		result.
	]
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> initialize [ 

	super initialize.
	mutants := self mutants.
	sensitivity := 0.05.
	
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> mutants [
	| analysis mutants |
	"TODO: review me"
	analysis := MTAnalysis new
		            classesToMutate: self classesToMutate;
		            mutantGenerationStrategy:
			            (MTManualMutatedMethodGenerationStrategy new
				             targetMethods: self target sendReachableMethods);
		            mutantSelectionStrategy:
			            MTRandomMethodMutantSelectionStrategy new.
	^ analysis generateMutations.
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> sensitivity [

	^ sensitivity
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> sensitivity: aSensitivy [

	sensitivity := aSensitivy
]

{ #category : 'as yet unclassified' }
PBTREEPerformanceMutantExperiment >> time [

	^ 10 seconds "2 minutes"
]
