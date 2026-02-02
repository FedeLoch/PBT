Class {
	#name : 'MTTestUmeCaseReference',
	#superclass : 'MTTestCaseReference',
	#category : 'Ume-Test generation',
	#package : 'Ume',
	#tag : 'Test generation'
}

{ #category : 'instance creation' }
MTTestUmeCaseReference class >> for: aPBTCase [

	^ self new initializeFor: aPBTCase
]

{ #category : 'building suites' }
MTTestUmeCaseReference >> buildSuite [

	^ testCase
]

{ #category : 'testing' }
MTTestUmeCaseReference >> isAbstract [
	
	^ false
]
