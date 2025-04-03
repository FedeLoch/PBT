Class {
	#name : 'PBTPerformanceOperations',
	#superclass : 'Object',
	#category : 'PBT-BugDetection',
	#package : 'PBT',
	#tag : 'BugDetection'
}

{ #category : 'accessing' }
PBTPerformanceOperations class >> operators [

	^ {
		  (MTAddSleepOperator time: 1) .
		  (MTAddSleepOperator time: 10) .
		  (MTAddSleepOperator time: 50) .
		  (MTAddSleepOperator time: 100)
	}
]
