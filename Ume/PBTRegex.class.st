Class {
	#name : 'UmeRegex',
	#superclass : 'Object',
	#instVars : [
		'regexString',
		'regex'
	],
	#category : 'Ume-Grammars',
	#package : 'Ume',
	#tag : 'Grammars'
}

{ #category : 'instance creation' }
UmeRegex class >> fromString: aString [

	^ self new
		  regexString: aString;
		  yourself
]

{ #category : 'ston-core' }
UmeRegex class >> stonAllInstVarNames [ 

	^ super stonAllInstVarNames copyWithout: #regex
]

{ #category : 'compiling' }
UmeRegex >> compileRegex [

	^ regexString asRegex
]

{ #category : 'testing' }
UmeRegex >> matches: aString [ 
	
	^ self regex matches: aString
]

{ #category : 'accessing' }
UmeRegex >> regex [

	^ regex ifNil: [ regex := regexString asRegex ]
]

{ #category : 'accessing' }
UmeRegex >> regexString [

	^ regexString
]

{ #category : 'accessing' }
UmeRegex >> regexString: anObject [

	regexString := anObject
]
