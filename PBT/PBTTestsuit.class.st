Class {
	#name : 'PBTTestsuit',
	#superclass : 'Object',
	#instVars : [
		'tests'
	],
	#category : 'PBT-Test generation',
	#package : 'PBT',
	#tag : 'Test generation'
}

{ #category : 'instance creation' }
PBTTestsuit class >> from: tests [

	^ self new tests: tests
]

{ #category : 'accessing' }
PBTTestsuit >> tests [

	^ tests
]

{ #category : 'accessing' }
PBTTestsuit >> tests: someTests [

	tests := someTests 
]
