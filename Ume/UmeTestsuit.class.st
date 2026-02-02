Class {
	#name : 'UmeTestsuit',
	#superclass : 'Object',
	#instVars : [
		'tests'
	],
	#category : 'Ume-Test generation',
	#package : 'Ume',
	#tag : 'Test generation'
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
