Class {
	#name : 'MTTestPBTCaseReference',
	#superclass : 'MTTestCaseReference',
	#category : 'Ume-Test generation',
	#package : 'Ume',
	#tag : 'Test generation'
}

{ #category : 'instance creation' }
MTTestPBTCaseReference class >> for: aPBTCase [

	^ self new initializeFor: aPBTCase
]

{ #category : 'building suites' }
MTTestPBTCaseReference >> buildSuite [

	^ testCase
]

{ #category : 'testing' }
MTTestPBTCaseReference >> isAbstract [
	
	^ false
]
