Class {
	#name : 'MTTestUmeCaseReference',
	#superclass : 'MTTestCaseReference',
	#category : 'Ume-Test Generation',
	#package : 'Ume',
	#tag : 'Test Generation'
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
