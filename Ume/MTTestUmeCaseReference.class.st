Class {
	#name : 'MTTestUmeCaseReference',
	#superclass : 'MTTestCaseReference',
	#category : 'Ume-Test generation',
	#package : 'Ume',
	#tag : 'Test generation'
}

{ #category : 'instance creation' }
MTTestUmeCaseReference class >> for: aUmeCase [

	^ self new initializeFor: aUmeCase
]

{ #category : 'building suites' }
MTTestUmeCaseReference >> buildSuite [

	^ testCase
]

{ #category : 'testing' }
MTTestUmeCaseReference >> isAbstract [
	
	^ false
]
