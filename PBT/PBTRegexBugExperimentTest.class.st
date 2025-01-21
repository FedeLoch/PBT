Class {
	#name : 'PBTRegexBugExperimentTest',
	#superclass : 'PBTFrameworkTest',
	#instVars : [
		'schema'
	],
	#category : 'PBT-FrameworkTests',
	#package : 'PBT',
	#tag : 'FrameworkTests'
}

{ #category : 'tests' }
PBTRegexBugExperimentTest >> testGivingARegexFuzzerAndAHillClimbingGeneratorThenWeForceThePerformanceBug [

	| pbtResult |
	
	pbtResult := PBTRunner test: Integer >> #factorial from: schema times: 10000.
	"Definir la nocion de score y utilizar 
	
	PBTGenerator base: [ 'asdef' ] mutating: [ :value |"

	self assertSuccess: pbtResult.
	self assert: (pbtResult tests size) equals: 10000.

]
