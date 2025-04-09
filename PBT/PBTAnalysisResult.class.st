Class {
	#name : 'PBTAnalysisResult',
	#superclass : 'Object',
	#instVars : [
		'sensitivity',
		'comparisons',
		'baseline',
		'threshold',
		'mutants'
	],
	#category : 'PBT-BugDetection',
	#package : 'PBT',
	#tag : 'BugDetection'
}

{ #category : 'adding' }
PBTAnalysisResult >> add: result called: label forMutant: mutant [

	comparisons at: label ifAbsentPut: Dictionary new.
	mutants at: mutant operator title update: [ :val | val + 1 ] initial: 0.
	(comparisons at: label)
		at: mutant operator title
		update: [ :val | val + (self incremental: result) ]
		initial: 0
]

{ #category : 'as yet unclassified' }
PBTAnalysisResult >> baseline: aBaseline [

	| times |
	
	baseline := aBaseline.
	times := aBaseline tests collect: [ :e | e result time asMilliSeconds ].
	threshold := times max.
]

{ #category : 'adding' }
PBTAnalysisResult >> incremental: result [

	| threshold2 |
	
	threshold2 := baseline bloxplotByTime median * (1 + sensitivity).
	
	^ (result bloxplotByTime median > threshold2) ifTrue: [ 1 ] ifFalse: [ 0 ]
]

{ #category : 'adding' }
PBTAnalysisResult >> initialize [ 

	super initialize.
	comparisons := Dictionary new.
	mutants := Dictionary new.
	
]

{ #category : 'private - inspector accessing' }
PBTAnalysisResult >> plot [
	| plt legend |
	plt := RSCompositeChart new.
	
	plt extent: 400@400.
	legend := RSLegend new.
	legend container: plt canvas.
	legend layout horizontal gapSize: 30.
	
	comparisons keysDo: [ :strategy | | p x y color |
		x := OrderedCollection new.
		y := OrderedCollection new.

		((comparisons at: strategy) keys sort: [ :m1 :m2 | (m1 splitOn: ' ') last asInteger < (m2 splitOn: ' ') last asInteger ]) do: [ :mutant |
			x add: (mutant splitOn: ' ') last asInteger.
			y add: (comparisons at: strategy at: mutant) / (mutants at: mutant)
		].
		
		color := Color random.
		p := RSLinePlot new x: x y: y; color: color.
		legend text: strategy withBoxColor: color.
		plt add: p
	].
	
	plt xlabel: 'mutation time'.
	plt ylabel: 'rate of detected mutants'.
	
	plt build.
	legend build.

	^ plt yLog; canvas
]

{ #category : 'as yet unclassified' }
PBTAnalysisResult >> sensitivity: aSensitivity [

	sensitivity := aSensitivity.
]
