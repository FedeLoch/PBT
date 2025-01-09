Class {
	#name : 'PBTRegexGenerator',
	#superclass : 'PBTGenerator',
	#instVars : [
		'regex'
	],
	#category : 'PBT-Generators',
	#package : 'PBT',
	#tag : 'Generators'
}

{ #category : 'accessing' }
PBTRegexGenerator >> gen: myConstraint [

	"Gen a random string that matchs with the instance variable regex"
	^ 'BLA'
]

{ #category : 'accessing' }
PBTRegexGenerator >> regex: aRegex [

	regex := aRegex 
]
