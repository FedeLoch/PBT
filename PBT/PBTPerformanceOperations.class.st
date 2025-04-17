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
		  (MTAddSleepOperator time: 0).
		  (MTAddSleepOperator time: 1).
		  (MTAddSleepOperator time: 2).
		  (MTAddSleepOperator time: 5).
		  (MTAddSleepOperator time: 10).
		  (MTAddSleepOperator time: 12).
		  (MTAddSleepOperator time: 15).
		  (MTAddSleepOperator time: 20).
		  (MTAddSleepOperator time: 25).
		  (MTAddSleepOperator time: 50).
		  (MTAddSleepOperator time: 100) }
]
