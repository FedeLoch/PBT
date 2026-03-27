Class {
	#name : 'UmeTestsuit',
	#superclass : 'Object',
	#instVars : [
		'tests'
	],
	#category : 'Ume-Test Generation',
	#package : 'Ume',
	#tag : 'Test Generation'
}

{ #category : 'instance creation' }
UmeTestsuit class >> from: tests [

	^ self new tests: tests
]

{ #category : 'accessing' }
UmeTestsuit >> tests [

	^ tests
]

{ #category : 'accessing' }
UmeTestsuit >> tests: someTests [

	tests := someTests 
]
