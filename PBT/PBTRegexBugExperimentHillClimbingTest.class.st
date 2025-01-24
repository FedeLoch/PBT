Class {
	#name : 'PBTRegexBugExperimentHillClimbingTest',
	#superclass : 'PBTRegexBugExperimentTest',
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'tests' }
PBTRegexBugExperimentHillClimbingTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBug [

	| pbtResult |
	
	self timeLimit: 20 minutes.
	pbtResult := PBTRunner test: RxMatcher >> #matches: from: schema times: 10000.
	
	self assert: (pbtResult tests size) equals: 10000.

]
