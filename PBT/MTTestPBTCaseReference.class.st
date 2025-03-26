Class {
	#name : 'MTTestPBTCaseReference',
	#superclass : 'MTTestCaseReference',
	#category : 'PBT-Test generation',
	#package : 'PBT',
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
