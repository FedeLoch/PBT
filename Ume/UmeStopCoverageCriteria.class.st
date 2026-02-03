Class {
	#name : 'UmeStopCoverageCriteria',
	#superclass : 'UmeStopCriteria',
	#instVars : [
		'tolerance',
		'previousCoverage',
		'timesWithouImprovement'
	],
	#category : 'Ume-Runner',
	#package : 'Ume',
	#tag : 'Runner'
}

{ #category : 'asserting' }
UmeStopCoverageCriteria >> improvesCoverage: aCoverage [
	previousCoverage ifNil: [ ^true ].
	
	(aCoverage asPercent = previousCoverage asPercent) ifTrue: [ timesWithouImprovement := timesWithouImprovement - 1 ].
	
	(aCoverage asPercent > previousCoverage asPercent ) ifTrue: [ timesWithouImprovement := tolerance ].

	^ timesWithouImprovement ~= 0
]

{ #category : 'asserting' }
UmeStopCoverageCriteria >> initialize [ 
	
	super initialize.
	tolerance := 100.
	timesWithouImprovement := tolerance .
]

{ #category : 'asserting' }
UmeStopCoverageCriteria >> isNotOneHundredPercent: aCoverage [

	^ aCoverage asPercent ~= 100
]

{ #category : 'asserting' }
UmeStopCoverageCriteria >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	| res |
	"Stop when the coverage is not improved since X iterations or the last coverage got 100%"
	res := (self isNotOneHundredPercent: aCoverage) and: [ self improvesCoverage: aCoverage ].
	previousCoverage := aCoverage.
	^ res
]

{ #category : 'accessing' }
UmeStopCoverageCriteria >> tolerance: aTolerance [

	tolerance := aTolerance.
	timesWithouImprovement := aTolerance.
]
