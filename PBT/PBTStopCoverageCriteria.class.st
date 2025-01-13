Class {
	#name : 'PBTStopCoverageCriteria',
	#superclass : 'PBTStopCriteria',
	#instVars : [
		'tolerance',
		'previousCoverage',
		'timesWithouImprovement'
	],
	#category : 'PBT-Runner',
	#package : 'PBT',
	#tag : 'Runner'
}

{ #category : 'asserting' }
PBTStopCoverageCriteria >> improvesCoverage: aCoverage [
	previousCoverage ifNil: [ ^true ].
	
	(aCoverage asPercent = previousCoverage asPercent) ifTrue: [ timesWithouImprovement := timesWithouImprovement - 1 ].
	
	(aCoverage asPercent > previousCoverage asPercent ) ifTrue: [ timesWithouImprovement := tolerance ].

	^ timesWithouImprovement ~= 0
]

{ #category : 'asserting' }
PBTStopCoverageCriteria >> initialize [ 
	
	super initialize.
	tolerance := 100.
	timesWithouImprovement := tolerance .
]

{ #category : 'asserting' }
PBTStopCoverageCriteria >> isNotOneHundredPercent: aCoverage [

	^ aCoverage asPercent ~= 100
]

{ #category : 'asserting' }
PBTStopCoverageCriteria >> shouldGenNext: currentTests since: aTime withCoverage: aCoverage [

	| res |
	"Stop when the coverage is not improved since X iterations or the last coverage got 100%"
	res := (self isNotOneHundredPercent: aCoverage) and: [ self improvesCoverage: aCoverage ].
	previousCoverage := aCoverage.
	^ res
]

{ #category : 'accessing' }
PBTStopCoverageCriteria >> tolerance: aTolerance [

	tolerance := aTolerance.
	timesWithouImprovement := aTolerance.
]
